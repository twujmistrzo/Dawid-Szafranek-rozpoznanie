for krok=1:10
    
% Create a cascade detector object.
faceDetector = vision.CascadeObjectDetector();

% Read a video frame and run the face detector.
% videoFileReader = vision.VideoFileReader('tilted_face.avi');
% videoFrame      = step(videoFileReader);
% for krok=1:10
 figure(1);
 subplot(2,5,krok);
 img=snapshot(cam);
 hold on;
% end
videoFrame=img;
bbox            = step(faceDetector, videoFrame);

% Draw the returned bounding box around the detected face.
videoFrame = insertShape(videoFrame, 'Rectangle', bbox);
figure; imshow(videoFrame); title('Detected face');

% pobranie obrazu z kamery robota
cam1=rossubscriber('/darwin/camera/image_raw'); 
img1=receive(cam1);
figure(2);
subplot(2,5,krok);
imshow(readImage(img1));
hold on;

% rozpoznanie twarzy
if(isempty(bbox)~=1)
    length(bbox)
sterowanie=rospublisher('/darwin/j_pan_position_controller/command');
sterowanie1=rospublisher('/darwin/j_low_arm_r_position_controller/command');
pozycja=rosmessage(sterowanie.MessageType);
pozycja1=rosmessage(sterowanie.MessageType);
pozycja.Data= -1.5;
pozycja1.Data= (pi/3);
send(sterowanie,pozycja);
send(sterowanie1,pozycja1);
pause(3);
pozycja.Data=0;
pozycja1.Data=0;
pause(3);
send(sterowanie,pozycja);
send(sterowanie1,pozycja1);

 end
 end