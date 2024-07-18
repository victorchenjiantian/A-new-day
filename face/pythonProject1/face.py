import cv2
import numpy as np

cap = cv2.VideoCapture(0)

while (cap.isOpened()):
    ret, img = cap.read()
    # print(ret)
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

cap.release()
cv2.destroyAllWindows()