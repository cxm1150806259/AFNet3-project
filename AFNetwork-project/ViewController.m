//
//  ViewController.m
//  AFNetwork-project
//
//  Created by Xianmin Chen on 2018/8/1.
//  Copyright © 2018年 MK. All rights reserved.
//

#import "ViewController.h"
#import "MKAccountService.h"


#define SERVICE_UUID        @"CDD1"
#define CHARACTERISTIC_UUID @"CDD2"

@interface ViewController () 
@property (nonatomic, strong) CBCentralManager *centralManager;
@property (nonatomic, strong) CBPeripheral *peripheral;
@property (nonatomic, strong) CBCharacteristic *characteristic;
@property (nonatomic, strong) NSMutableDictionary *deviceDic;
@property (nonatomic, weak) id<CBCentralManagerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *scanDevice;
@property (weak, nonatomic) IBOutlet UIButton *disconnectDevice;
@property (weak, nonatomic) IBOutlet UIButton *shakeBtn;
@property (weak, nonatomic) IBOutlet UIButton *stopShakeBtn;
@property (weak, nonatomic) IBOutlet UITextView *deviceInfoList;
- (IBAction)scanPress:(id)sender;
- (IBAction)disconnectPress:(id)sender;
- (IBAction)shakePress:(id)sender;
- (IBAction)stopShakePress:(id)sender;
@end

@implementation ViewController
//@synthesize age = _age;
- (void)viewDidLoad {
    [super viewDidLoad];
    //创建中心设备管理器，会回调CentralManagerDidUpdateState
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
    
    
    
}

/** 判断手机蓝牙状态
 CBManagerStateUnknown = 0,  未知
 CBManagerStateResetting,    重置中
 CBManagerStateUnsupported,  不支持
 CBManagerStateUnauthorized, 未验证
 CBManagerStatePoweredOff,   未启动
 CBManagerStatePoweredOn,    可用
 */
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    // 蓝牙可用，开始扫描外设
    if (central.state == CBManagerStatePoweredOn) {
        NSLog(@"蓝牙可用");
        self.centralManager = central;
        // 根据SERVICE_UUID来扫描外设，如果不设置SERVICE_UUID，则扫描所有蓝牙设备
//        [central scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:SERVICE_UUID]] options:nil];
//        [central scanForPeripheralsWithServices:nil options:nil];
        
    }
    if(central.state==CBManagerStateUnsupported) {
        NSLog(@"该设备不支持蓝牙");
    }
    if (central.state==CBManagerStatePoweredOff) {
        NSLog(@"蓝牙已关闭");
    }
}

/** 发现符合要求的外设，回调 */
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI {
    NSLog(@"Find device:%@",[peripheral name]);
//    if (![_deviceDic objectForKey:[peripheral name]]) {
//        NSLog(@"Find device:%@",[peripheral name]);
//        if (peripheral!=nil) {
//            if ([peripheral name]!=nil) {
//                if ([[peripheral name] hasPrefix:@"M"]) {
//                    [_deviceDic setObject:peripheral forKey:[peripheral name]];
//                    //停止扫描，看需求决定要不要加
////                    [_centralManager stopScan];
//                    //将设备信息传到外面的页面（VC），构成扫描到的设备列表
////                    if ([self.delegate respondsToSelector:@selector(dataWithBluetoothDic:)]) {
//////                        [self.delegate dataWithBluetoothDic:_deviceDic];
////                    }
//                }
//            }
//        }
//    }
    if ([[peripheral name] hasPrefix:@"M"]){
        // 对外设对象进行强引用
        self.peripheral = peripheral;
        
        //    if ([peripheral.name hasPrefix:@"WH"]) {
        //        // 可以根据外设名字来过滤外设
        //        [central connectPeripheral:peripheral options:nil];
        //    }
        
        // 连接外设
        [central connectPeripheral:peripheral options:nil];
    }
    
}

/** 连接成功 */
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    // 可以停止扫描
    [self.centralManager stopScan];
    // 设置代理
    peripheral.delegate = self;
    // 根据UUID来寻找服务
    [peripheral discoverServices:@[[CBUUID UUIDWithString:SERVICE_UUID]]];
    NSLog(@"连接成功");
}

/** 连接失败的回调 */
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"连接失败");
}

/** 断开连接 */
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    NSLog(@"断开连接");
    // 断开连接可以设置重新连接
    [central connectPeripheral:peripheral options:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark - CBPeripheralDelegate

/** 发现服务 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    
    // 遍历出外设中所有的服务
    for (CBService *service in peripheral.services) {
        NSLog(@"所有的服务：%@",service);
    }
    
    // 这里仅有一个服务，所以直接获取
    CBService *service = peripheral.services.lastObject;
    // 根据UUID寻找服务中的特征
    [peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:CHARACTERISTIC_UUID]] forService:service];
}

/** 发现特征回调 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    
    // 遍历出所需要的特征
    for (CBCharacteristic *characteristic in service.characteristics) {
        NSLog(@"所有特征：%@", characteristic);
        // 从外设开发人员那里拿到不同特征的UUID，不同特征做不同事情，比如有读取数据的特征，也有写入数据的特征
    }
    
    // 这里只获取一个特征，写入数据的时候需要用到这个特征
    self.characteristic = service.characteristics.lastObject;
    
    // 直接读取这个特征数据，会调用didUpdateValueForCharacteristic
    [peripheral readValueForCharacteristic:self.characteristic];
    
    // 订阅通知
    [peripheral setNotifyValue:YES forCharacteristic:self.characteristic];
}

/** 订阅状态的改变 */
-(void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (error) {
        NSLog(@"订阅失败");
        NSLog(@"%@",error);
    }
    if (characteristic.isNotifying) {
        NSLog(@"订阅成功");
    } else {
        NSLog(@"取消订阅");
    }
}

/** 接收到数据回调 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    // 拿到外设发送过来的数据
    NSData *data = characteristic.value;
//    self.textField.text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",data);
}

/** 写入数据回调 */
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(nonnull CBCharacteristic *)characteristic error:(nullable NSError *)error {
    NSLog(@"写入成功");
}

- (IBAction)scanPress:(id)sender {
    [self.centralManager scanForPeripheralsWithServices:nil options:nil];
}

- (IBAction)disconnectPress:(id)sender {
    
}

- (IBAction)shakePress:(id)sender {
}

- (IBAction)stopShakePress:(id)sender {
}
@end
