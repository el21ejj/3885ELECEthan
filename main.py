#Shows Pi is on by turning on LED when plugged in
LED = machine.Pin("LED", machine.Pin.OUT)
LED.on()

from imu import MPU6050
from time import sleep
from machine import Pin, I2C,UART
import urequests
import network
import time

i2c = I2C(0, sda=Pin(0), scl=Pin(1), freq=400000)
led = Pin(25,Pin.OUT)
uart = machine.UART(1, baudrate=9600, rx=machine.Pin(5), tx=machine.Pin(4))
led = Pin(13, Pin.OUT)
led.value(0)

imu = MPU6050(i2c)

def from_pi():
 value = uart.read(1)
 if value:
    value = int.from_bytes(value, 'little')
    
    if value == 1:
        led.value(1)
        print('standing')
    elif value == 0:
        led.value(0)
        print('walking')
        

    
while True:
    ax=imu.accel.x
    ax_offset = 0.001024487*ax + 0.03741841
    ax_with_offset = ax - ax_offset
    ay=imu.accel.y
    ay_offset = -0.007631091*ay - 0.001561842
    ay_with_offset = ay - ay_offset
    az=imu.accel.z
    az_offset = 0.01199424*az + 0.05399156
    az_with_offset = az - az_offset
    gx=imu.gyro.x + 0.2490928
    gy=imu.gyro.y +0.8915495
    gz=imu.gyro.z -1.095181
    print(ax)
    print(ay)
    print(az)
    print(gx)
    print(gy)
    print(gz)
    

    uart.write("{:.6f}".format(ax),)
    uart.write(',')
    uart.flush()
    uart.write("{:.6f}".format(ay),)
    uart.write(',')
    uart.flush()
    uart.write("{:.6f}".format(az),)
    uart.write(',')
    uart.flush()
    uart.write("{:.6f}".format(gx),)
    uart.write(',')
    uart.flush()
    uart.write("{:.6f}".format(gy),)
    uart.write(',')
    uart.flush()
    uart.write("{:.6f}".format(gz),)
    uart.write(',')
    uart.flush()

    time.sleep(0.01)
    from_pi()