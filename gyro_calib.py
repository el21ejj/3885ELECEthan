from imu import MPU6050
from machine import Pin, I2C
import time
from time import sleep

i2c = I2C(0, sda=Pin(0), scl=Pin(1), freq=400000)
imu = MPU6050(i2c)
t0 = time.time()

settling_time = 4
print('Settling MPU for %d seconds' % settling_time)
time.sleep(4)
print('MPU is Done Settling')


def get_gyro():
    gx=imu.gyro.x
    gy=imu.gyro.y
    gz=imu.gyro.z
    return gx, gy, gz
    

def gyro_calibration(calibration_time=10):

    print('--' * 25)
    print('Beginning Gyro Calibration - Do not move the MPU6050')
    
 
    offsets = [0, 0, 0]
    
    num_of_points = 0
    
    
    end_loop_time = time.time() + calibration_time
   
    while end_loop_time > time.time():
        num_of_points += 1
        (gx, gy, gz) = get_gyro()
        offsets[0] += gx
        offsets[1] += gy
        offsets[2] += gz
        
     
        if num_of_points % 100 == 0:
            print('Still Calibrating Gyro... %d points so far' % num_of_points)
        
    print('Calibration for Gyro is Complete! %d points total' % num_of_points)
    offsets = [i/num_of_points for i in offsets] 
    return offsets
print(gyro_calibration())