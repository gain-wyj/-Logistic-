function varargout = logistic(varargin)
% LOGISTIC MATLAB code for logistic.fig
%      LOGISTIC, by itself, creates a new LOGISTIC or raises the existing
%      singleton*.
%
%      H = LOGISTIC returns the handle to a new LOGISTIC or the handle to
%      the existing singleton*.
%
%      LOGISTIC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LOGISTIC.M with the given input arguments.
%
%      LOGISTIC('Property','Value',...) creates a new LOGISTIC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before logistic_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to logistic_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help logistic

% Last Modified by GUIDE v2.5 16-Nov-2019 20:48:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @logistic_OpeningFcn, ...
                   'gui_OutputFcn',  @logistic_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before logistic is made visible.
function logistic_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to logistic (see VARARGIN)

% Choose default command line output for logistic
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes logistic wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = logistic_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Open.
function Open_Callback(hObject, eventdata, handles)                     % 打开图像
% hObject    handle to Open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'*.bmp;*.jpg;*.png;*.jpeg;*.tif;*.gif;*.Image files'},'载入图像');%选择路径打开图像
if isequal(filename,0)||isequal(pathname,0)%若filename为0或pathname为0，即未选中文件
    errordlg('未选中文件','警告');%建立一个名为警告的错误对话框，内容为“未选中文件”
    return;
end
str=[pathname,filename];    %将文件名和目录名组合成一个完整的路径
x=imread(str);              %读入图像
axes(handles.axes1);        %定义图形区域axes1
imshow(x);                  %显示图像
handles.img=x;              %把图像发给handles.img
guidata(hObject,handles);   %把handles句柄更新

figure(1);
hist_im=histogram(handles.img); %加密前直方图
title('原始图像直方图');


% --- Executes on button press in Save.
function Save_Callback(hObject, eventdata, handles)                     % 保存图像
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] =uiputfile({'*.jpg','JPEG(*.jpg)';'*.bmp','Bitmap(*.bmp)';'*.gif','GIF(*.gif)';'*.*', 'All Files (*.*)'},'Save Picture','WYJ');
if FileName==0
    return;
else
    h=getframe(handles.axes2);
    imwrite(h.cdata,[PathName,FileName]);
end


% --- Executes on button press in Ptzl_jiami.
function Ptzl_jiami_Callback(hObject, eventdata, handles)               %普通置乱加密
% hObject    handle to Ptzl_jiami (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s = size(handles.img);
% 将picture分为3列，每列768/3=256个元素
%%% 随机打乱各行进行加密
% 不放回的均匀分布的从1到s(1)取整数，个数为s(1)抽样
r = randsample(s(1), s(1)); % r为256*1的矩阵，得到256个不相同的数
RGBS = handles.img(r, :, :);    % 得到一个256*256的图像矩阵
%%% 随机打乱各列进行加密
c = randsample(s(2), s(2)); % c为256*1的矩阵，得到256个不相同的数
RGBSS = RGBS(:, c, :);
axes(handles.axes2);        %定义图形区域axes2
imshow(RGBSS); 
title('普通置乱加密图像');

figure(2);
hist_im=histogram(RGBSS); %加密后直方图
title('普通置乱加密直方图');


% --- Executes on button press in Ptzl_jiemi.
function Ptzl_jiemi_Callback(hObject, eventdata, handles)               % 普通置乱解密
% hObject    handle to Ptzl_jiemi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s = size(handles.img);
% 将picture分为3列，每列768/3=256个元素
%%% 随机打乱各行进行加密
% 不放回的均匀分布的从1到s(1)取整数，个数为s(1)抽样
r = randsample(s(1), s(1)); % r为256*1的矩阵，得到256个不相同的数
RGBS = handles.img(r, :, :);    % 得到一个256*256的图像矩阵
%%% 随机打乱各列进行加密
c = randsample(s(2), s(2)); % c为256*1的矩阵，得到256个不相同的数
RGBSS = RGBS(:, c, :);
%%% 按列进行解密
i = 1; 
f = 1:length(c);    % f为1*256的矩阵
while i <= length(c)
    f(i) = find(c == i);
    i = i + 1;
end
RGBE = RGBSS(:, f, :);
%%% 按行进行解密
j = 1;
g = 1:length(r);    % g为1*192的矩阵
while j <= length(r)
    g(j) = find(r == j);
    j = j + 1;
end
RGBEE = RGBE(g, :, :);
axes(handles.axes3);        %定义图形区域axes3
imshow(RGBEE); 
title('普通置乱解密图像');


% --- Executes on button press in Logistic_jiami.
function Logistic_jiami_Callback(hObject, eventdata, handles)           % 混沌Logistic加密
% hObject    handle to Logistic_jiami (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[M,N]=size(handles.img); % 获取图片尺寸
p1 = {'输入加密密钥： '};
p2 = {'0.1'};
p3 = inputdlg(p1,'输入加密密钥：0-1 ',1,p2);
x=str2num(p3{1});
disp('混沌Logistic加密中...');

% x=0.1;  % 定义初值x(0)=0.1 
u=4;      % 定义参数u=4

%迭代500次，达到充分混沌状态
for i=1:500 
    x=u*x*(1-x); 
end 
fprintf('x(k+1)=%d\n',x); % 输出迭代后的x的值

% picture是水印，D是水印对应的矩阵
% Imgn是混沌矩阵，Rod是水印与混沌异或结果
% img是还原出来的水印

%产生一维混沌加密序列 
A=zeros(1,M*N);     % 产生一个1-M*N的double类型的矩阵
A(1)=x;             % 定义一维混沌初值
for i=1:M*N-1 
    A(i+1)=u*A(i)*(1-A(i)); 
end

%归一化序列 
B=uint8(255*A); % 产生一个1*M×N的uint8类型的矩阵

% 转化为二维混沌加密序列
% 将矩阵B的元素返回到一个M×N的矩阵Imgn,其中Imgn是混沌矩阵
Imgn=reshape(B,M,N);   % 按照列的顺序进行转换的，也就是第一列读完，读第二列，按列存放

C=zeros(M,N); 
for x=1:M 
    for y=1:N 
        C(x,y)=handles.img(x,y); 
    end
end
C; 
D=uint8(C); % D是水印图像对应的矩阵

%异或操作加密(Logistic混沌序列加密)
Rod=bitxor(D,Imgn); %异或操作加密（水印矩阵和二维混沌序列异或结果）
Rod; 
%转化成uint8后图像会变成二维，原来的picture是256*256*3的三通道后面转换成256*768了，
%显示是三个图片，用rgb分别显示了，合成一个图片要用reshape（Rod，M,N/3,3）转化回去
rod=reshape(Rod,M,N/3,3); % 把Rod中元素进行重塑成M×N/3×3的矩阵
axes(handles.axes2);        %定义图形区域axes2
imshow(rod); 
title('Logistic混沌加密图像');

figure(4);
hist_im=histogram(rod); %加密后直方图
title('Logistic混沌加密直方图');


% --- Executes on button press in Logistic_jiemi.
function Logistic_jiemi_Callback(hObject, eventdata, handles)           % 混沌Logistic解密
% hObject    handle to Logistic_jiemi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[M,N]=size(handles.img); % 获取图片尺寸
p1={'输入解密密钥： '};
p2={'0.1'};p3 = inputdlg(p1,'输入解密密钥：0-1 ',1,p2);
x=str2num(p3{1});
disp('混沌Logistic解密中...');

% x=0.1;  % 定义初值x(0)=0.1 
u=4;      % 定义参数u=4

%迭代500次，达到充分混沌状态
for i=1:500 
    x=u*x*(1-x); 
end 
fprintf('x(k+1)=%d\n',x); % 输出迭代后的x的值

% picture是水印，D是水印对应的矩阵
% Imgn是混沌矩阵，Rod是水印与混沌异或结果
% img是还原出来的水印

%产生一维混沌加密序列 
A=zeros(1,M*N);     % 产生一个1-M*N的double类型的矩阵
A(1)=x;             % 定义一维混沌初值
for i=1:M*N-1 
    A(i+1)=u*A(i)*(1-A(i)); 
end

%归一化序列 
B=uint8(255*A); % 产生一个1*M×N的uint8类型的矩阵

% 转化为二维混沌加密序列
% 将矩阵B的元素返回到一个M×N的矩阵Imgn,其中Imgn是混沌矩阵
Imgn=reshape(B,M,N);   % 按照列的顺序进行转换的，也就是第一列读完，读第二列，按列存放

C=zeros(M,N); 
for x=1:M 
    for y=1:N 
        C(x,y)=handles.img(x,y); 
    end
end
C; 
D=uint8(C); % D是水印图像对应的矩阵

%异或操作加密(Logistic混沌序列加密)
Rod=bitxor(D,Imgn); %异或操作加密（水印矩阵和二维混沌序列异或结果）
Rod; 
%转化成uint8后图像会变成二维，原来的picture是256*256*3的三通道后面转换成256*768了，
%显示是三个图片，用rgb分别显示了，合成一个图片要用reshape（Rod，M,N/3,3）转化回去
rod=reshape(Rod,M,N/3,3); % 把Rod中元素进行重塑成M×N/3×3的矩阵
% 进度条设置
% h = waitbar(x,'message')：x表示进度条的比例长度，message是在进度条上显示的信息
h= waitbar(0,'程序处理中，请耐心等待。。。');
for i=1:100 % computation here %
    waitbar(i/100)
end
close(h);

%异或操作解密（Logistic混沌序列解密）
Img=bitxor(Rod,Imgn);%异或操作解密 （加密图像与二维混沌序列异或进行解密）
%转化成uint8后图像会变成二维，原来的picture是256*256*3的三通道后面转换成256*768了，
%显示是三个图片，用rgb分别显示了，合成一个图片要用reshape（Img，M,N/3,3）转化回去
img=reshape(Img,M,N/3,3); 
axes(handles.axes3);        %定义图形区域axes3
imshow(img); 
title('Logistic混沌解密图像');


% --- Executes on button press in RGB_jiami.
function RGB_jiami_Callback(hObject, eventdata, handles)                % 像素点的RGB值缩放加密
% hObject    handle to RGB_jiami (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s = size(handles.img);
r = rand(s(1), s(2), s(3)) * 20;
RGBD = im2double(handles.img);
RGB_jiami = RGBD .* r;
axes(handles.axes2);        %定义图形区域axes2
imshow(RGB_jiami); 
title('像素点的RGB值缩放加密图像');

figure(3);
hist_im=histogram(RGB_jiami); %加密后直方图
title('像素点的RGB值缩放加密直方图');


% --- Executes on button press in RGB_jiemi.
function RGB_jiemi_Callback(hObject, eventdata, handles)                % 像素点的RGB值缩放解密
% hObject    handle to RGB_jiemi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s = size(handles.img);
r = rand(s(1), s(2), s(3)) * 20;    % 像素点的RGB值各放大20位
RGBD = im2double(handles.img);
RGB_jiami = RGBD .* r;      % 像素点的RGB值各放大20位
RGB_jiemi = RGB_jiami ./ r; % 像素点的RGB值各缩小20位
axes(handles.axes3);        %定义图形区域axes3
imshow(RGB_jiemi); 
title('像素点的RGB值缩放解密图像');


% --- Executes on button press in Exit.
function Exit_Callback(hObject, eventdata, handles)                     % 退出
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc         %清除指令窗
close all   %关闭所有句柄可见的窗口
close(gcf)  %关闭当前窗口
clear       %清除内存变量和函数



