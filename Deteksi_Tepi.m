function varargout = Deteksi_Tepi(varargin)
% DETEKSI_TEPI MATLAB code for Deteksi_Tepi.fig
%      DETEKSI_TEPI, by itself, creates a new DETEKSI_TEPI or raises the existing
%      singleton*.
%
%      H = DETEKSI_TEPI returns the handle to a new DETEKSI_TEPI or the handle to
%      the existing singleton*.
%
%      DETEKSI_TEPI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DETEKSI_TEPI.M with the given input arguments.
%
%      DETEKSI_TEPI('Property','Value',...) creates a new DETEKSI_TEPI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Deteksi_Tepi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Deteksi_Tepi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Deteksi_Tepi

% Last Modified by GUIDE v2.5 02-Dec-2016 00:45:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Deteksi_Tepi_OpeningFcn, ...
                   'gui_OutputFcn',  @Deteksi_Tepi_OutputFcn, ...
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


% --- Executes just before Deteksi_Tepi is made visible.
function Deteksi_Tepi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Deteksi_Tepi (see VARARGIN)

% Choose default command line output for Deteksi_Tepi
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Deteksi_Tepi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Deteksi_Tepi_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
set(handles.radiobutton2,'value',0);
 
[a]=[-1 0 -1;-2 0 -2;-1 0 1];
handles.a=a;
[b]=[1 2 1;0 0 0;-1 -2 -1];
handles.b=b;
[konva] = konv(handles.y,handles.a);
[konvb] = konv(handles.y,handles.b);
kon = [konva] + [konvb];
 
[kon]=tresh(kon);
handles.kon=kon;
guidata(hObject,handles);

% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2
set(handles.radiobutton1,'value',0);
 
[a]=[-1 0 1;-1 0 1;-1 0 1];
handles.a=a;
[b]=[1 1 1;0 0 0;-1 -1 -1];
handles.b=b;
[konva] = konv(handles.y,handles.a);
[konvb] = konv(handles.y,handles.b);
kon = [konva] + [konvb];
 
[kon]=tresh(kon);
handles.kon=kon;
guidata(hObject,handles);

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile(...
    {'*.bmp;*.jpg;*.tif;*.gif','file lukisan (*.bmp,*.jpg,*.tif,*.gif)';
    '*.bmp', 'gambar bmp (*.bmp)';...
    '*.jpg', 'gambar JPEG (*.jpg)';...
    '*.tif', 'gambar tif (*.tif)';...
    '*.gif', 'gambar gif (*.gif)';...
    '*.*', 'semua File (*.*)'},...
    'pick a file');
 
y = imread (fullfile(pathname,filename));
[m n] = size(y);
axes(handles.axes1);
imshow(y);
handles.y=y;
handles.m=m;
handles.n=n;
guidata(hObject,handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[edge]=tresh(handles.kon);
kon = uint8(handles.kon);
axes(handles.axes2);
imshow(kon);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.figure1);

function [tresh] = tresh(kon)
[m n k] = size(kon);
kon = double(kon);
for i = 1 : m
    for j = 1 : n
        if kon(i,j) >= 128
            tresh(i,j) = 255;
        else
            tresh(i,j) = 0;
        end
    end
end
 
function [konv]=konv(x,mask)
if size(x,3) == 1
    x = double(x);
    [m n] = size(x);
    
    for i = 2 : m-1
        for j = 2 : n-1
            konv(i,j)= x(i-1,j-1)*mask(1,1)+x(i-1,j)*mask(1,2)+x(i-1,j+1)*mask(1,3)+...
                       x(i,j-1)*mask(2,1)+x(i,j)*mask(2,2)+x(i,j+1)*mask(2,3)+...
                       x(i+1,j-1)*mask(3,1)+x(i+1,j)*mask(3,2)+x(i+1,j+1)*mask(3,3);
            if konv(i,j)<0
                konv(i,j)=0;
            elseif konv(i,j)>225
                konv(i,j)=255;
            end
        end
    end
else
    [m n] = size(x(:,:,3));
    x = double(x);
    for i = 2 : m-1
        for j = 2 : n-1
            konv(i,j,1) = x(i-1,j-1,1)*mask(1,1)+x(i-1,j,1)*mask(1,2)+x(i-1,j+1,1)*mask(1,3)+...
                          x(i,j-1,1)*mask(2,1)+x(i,j,1)*mask(2,2)+x(i,j+1,1)*mask(2,3)+...
                          x(i+1,j-1,1)*mask(3,1)+x(i+1,j,1)*mask(3,2)+x(i+1,j+1,1)*mask(3,3);
            konv(i,j,2) = x(i-1,j-1,2)*mask(1,1)+x(i-1,j,2)*mask(1,2)+x(i-1,j+1,2)*mask(1,3)+...
                          x(i,j-1,2)*mask(2,1)+x(i,j,2)*mask(2,2)+x(i,j+1,2)*mask(2,3)+...
                          x(i+1,j-1,2)*mask(3,1)+x(i+1,j,2)*mask(3,2)+x(i+1,j+1,2)*mask(3,3);                   
            konv(i,j,3) = x(i-1,j-1,3)*mask(1,1)+x(i-1,j,3)*mask(1,2)+x(i-1,j+1,3)*mask(1,3)+...
                          x(i,j-1,3)*mask(2,1)+x(i,j,3)*mask(2,2)+x(i,j+1,3)*mask(2,3)+...
                          x(i+1,j-1,3)*mask(3,1)+x(i+1,j,3)*mask(3,2)+x(i+1,j+1,3)*mask(3,3);                   
            if konv(i,j)<0
                konv(i,j)=0;
            elseif konv(i,j)>225
                konv(i,j)=255;
            end
        end
    end
end
