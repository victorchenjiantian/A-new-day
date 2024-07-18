from socket import *
from time import ctime
import cv2
cap = cv2.VideoCapture(0)
 
HOST = ''
PORT = 7777
BUFSIZ = 1024
ADDR = (HOST,PORT)
 
tcpSerSock = socket(AF_INET,SOCK_STREAM)
tcpSerSock.bind(ADDR)
tcpSerSock.listen(5)
 
while True:
    print('waiting for connection...')
    tcpCliSock, addr = tcpSerSock.accept()
    print('...connnecting from:', addr)
 
    while True:
        ret, img = cap.read()
        data = tcpCliSock.recv(BUFSIZ)
        if ret:
            gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
            faceCascade = cv2.CascadeClassifier('haarcascade_frontalface_default.xml')
            faces_rects = faceCascade.detectMultiScale(img, scaleFactor=1.1, minNeighbors=5, minSize=(30, 30),
                                                       flags=cv2.CASCADE_SCALE_IMAGE)
            a = 0
            for (x, y, w, h) in faces_rects:
                print("True")
                a = 1
                img = cv2.rectangle(img, (x, y), (x + w, y + h), (255, 0, 0), 2)
            if a == 0:
                print("False")

            cv2.imshow('Press Spacebar to Exit', img)

            if cv2.waitKey(10) & 0xFF == ord(' '):  # 按下空格键退出
                break
        else:
            break
        if not data:
            break
        #tcpCliSock.send('[%s] %s' %(bytes(ctime(),'utf-8'),data))
        #tcpCliSock.send(('[%s] %s' % (ctime(), data)).encode())
        tcpCliSock.send(input("请输入你要传输的信息").encode())
    tcpCliSock.close()
tcpSerSock.close()