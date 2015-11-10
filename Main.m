function varargout = Osteoporosis_Main(varargin)

if(~isdeployed)
	cd(fileparts(which(mfilename)));
end

% Osteoporosis_Main MATLAB code for Osteoporosis_Main.fig
%      Osteoporosis_Main, by itself, creates a new Osteoporosis_Main or raises the existing
%      singleton*.
%
%      H = Osteoporosis_Main returns the handle to a new Osteoporosis_Main or the handle to
%      the existing singleton*.
%
%      Osteoporosis_Main('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Osteoporosis_Main.M with the given input arguments.
%
%      Osteoporosis_Main('Property','Value',...) creates a new Osteoporosis_Main or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Osteoporosis_Main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Osteoporosis_Main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Osteoporosis_Main

% Last Modified by GUIDE v2.5 13-May-2015 20:47:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Osteoporosis_Main_OpeningFcn, ...
                   'gui_OutputFcn',  @Osteoporosis_Main_OutputFcn, ...
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


% --- Executes just before Osteoporosis_Main is made visible.
function Osteoporosis_Main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Osteoporosis_Main (see VARARGIN)

% Choose default command line output for Osteoporosis_Main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Osteoporosis_Main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Osteoporosis_Main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in open.
function open_Callback(hObject, eventdata, handles)
% hObject    handle to open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file_name, mach_path] = uigetfile( ...
       {'*.tif; *.bmp; *.jpg; *.jpeg;', 'Image Files (*.tif,*.bmp,*.jpg,*.jpeg)'}, ...
    'Select Image');
 
    % If "Cancel" is selected then return
 if isequal([file_name,mach_path],[0,0])
        return
       
 % Otherwise construct the fullfilename and check and load the file
 else
        File = fullfile(mach_path,file_name);
        [xray, map] = imread (File);
        [xx yy zz] = size (xray);
        
        %  If the xray input is RGB, then turn it to grayscale
        if (zz == 3)
            grayim = rgb2gray(xray);
            imshow(grayim, 'Parent', handles.axes1);
            
        %  Otherwise display xray as it is    
        else
            imshow(xray, 'Parent', handles.axes1);
        end

 end
        guidata(hObject, handles);

% Cropping ROI area

        %  Right Condylus mandibulae
        message = sprintf('Select right Condylus mandibulae');
        uiwait(msgbox(message));
        
        mask1 = imcrop(handles.axes1);
        mask1a=double(mask1);
        mask1a=mask1a(:,:,1);

        
        %  Left Condylus mandibulae
        message = sprintf('Select left Condylus mandibulae');
        uiwait(msgbox(message));
        
        mask2 = imcrop(handles.axes1);
        mask1b=double(mask2);
        mask1b=mask1b(:,:,1);
        
        % Display both right & left Condylus mandibulae
        cla(handles.axes1); % menyembunyikan gambar awal
        imshow(mask1, 'Parent', handles.axes8); % memunculkan hasil cropping Condylus mandibulae kanan 
        imshow(mask2, 'Parent', handles.axes9); % memunculkan hasil cropping Condylus mandibulae kiri
        
%  Selecting background (right)
        
        % Background 1
        
        message = sprintf('Select Background 1 from\nthe right Condylus mandibulae');
        uiwait(msgbox(message));
        
        H2 = imfreehand(handles.axes8); % mengambil ROI background ke-1
        mask2a = createMask(H2); % menampilkan masking
        mask2aa = mask1a.*(mask2a); % mengalikan mask1a dan mask2a

        numberOfPixels2 = bwarea(mask2a); % menghitung banyaknya pixel

        sumgrayimage2 = sum(sum(mask2aa)); % menjumlahkan nilai warna di mask2aa
        mean_kanan1 = sumgrayimage2/numberOfPixels2; % menghitung rata-rata
        
        % Background 2
        message = sprintf('Select Background 2 from\nthe right Condylus mandibulae');
        uiwait(msgbox(message));
        
        cla(handles.axes8);
        imshow(mask1, 'Parent', handles.axes8);        
        H3 = imfreehand(handles.axes8); % mengambil ROI background ke-2
        mask3a = createMask(H3); % menampilkan masking
        mask3aa = mask1a.*(mask3a); % mengalikan mask1a dan mask3a

        numberOfPixels3 = bwarea(mask3a); % menghitung banyaknya pixel
        sumgrayimage3 = sum(sum(mask3aa)); % menjumlahkan nilai warna di mask2aa
        mean_kanan2 = sumgrayimage3/numberOfPixels3; % menghitung rata-rata

        % Background 3        
        message = sprintf('Select Background 3 from\nthe right Condylus mandibulae');
        uiwait(msgbox(message));
        
        cla(handles.axes8);
        imshow(mask1, 'Parent', handles.axes8); 
        H4 = imfreehand(handles.axes8); % mengambil ROI background ke-2
        mask4a = createMask(H4); % menampilkan masking
        mask4aa = mask1a.*(mask4a); % mengalikan mask1a dan mask3a

        numberOfPixels4 = bwarea(mask4a); % menghitung banyaknya pixel
        sumgrayimage4 = sum(sum(mask4aa)); % menjumlahkan nilai warna di mask2aa
        mean_kanan3 = sumgrayimage4/numberOfPixels4; % menghitung rata-rata

% Selecting background (left)        
        
        % Background 1
        message = sprintf('Select Background 1 from\nthe left Condylus mandibulae');
        uiwait(msgbox(message));
        
        H5 = imfreehand(handles.axes9); % mengambil ROI background ke-2
        mask5a = createMask(H5); % menampilkan masking
        mask5aa = mask1b.*(mask5a); % mengalikan mask1a dan mask3a

        numberOfPixels5 = bwarea(mask5a); % menghitung banyaknya pixel
        sumgrayimage5 = sum(sum(mask5aa)); % menjumlahkan nilai warna di mask2aa
        mean_kiri1 = sumgrayimage5/numberOfPixels5; % menghitung rata-rata       
                        
        % Background 2
        message = sprintf('Select Background 2 from\nthe left Condylus mandibulae');
        uiwait(msgbox(message));
        
        cla(handles.axes9);
        imshow(mask2, 'Parent', handles.axes9);
        H6 = imfreehand(handles.axes9); % mengambil ROI background ke-2
        mask6a = createMask(H6); % menampilkan masking
        mask6aa = mask1b.*(mask6a); % mengalikan mask1a dan mask3a

        numberOfPixels6 = bwarea(mask6a); % menghitung banyaknya pixel
        sumgrayimage6 = sum(sum(mask6aa)); % menjumlahkan nilai warna di mask2aa
        mean_kiri2 = sumgrayimage6/numberOfPixels6; % menghitung rata-rata
        
        % Background 3
        message = sprintf('Select Background 3 from\nthe left Condylus mandibulae');
        uiwait(msgbox(message));
        cla(handles.axes9);
        imshow(mask2, 'Parent', handles.axes9);
        H7 = imfreehand(handles.axes9); % mengambil ROI background ke-2
        mask7a = createMask(H7); % menampilkan masking
        mask7aa = mask1b.*(mask7a); % mengalikan mask1a dan mask3a

        numberOfPixels7 = bwarea(mask7a); % menghitung banyaknya pixel
        sumgrayimage7 = sum(sum(mask7aa)); % menjumlahkan nilai warna di mask2aa
        mean_kiri3 = sumgrayimage7/numberOfPixels7; % menghitung rata-rata
 
% Processing ROI (right)
        
        %ROI kanan-1
        message = sprintf('Select ROI 1 from\nthe right Condylus mandibulae');
        uiwait(msgbox(message));
        H2a = minus(mask1,mean_kanan1); % mengurangi gambar mask 1 dengan nilai rata-rata
        maskH2a=double(H2a); % mengubah menjadi tipe double
        maskH2a=maskH2a(:,:,1); % mengambil bagian tertentu

        cla(handles.axes8);
        imshow(H2a, 'Parent', handles.axes8) % menampilkan gambar yang telah dikurangi
        ROI_kanan1 = imfreehand(handles.axes8); % memilih bagian ROI
        ROI_kanan1a = createMask(ROI_kanan1); % menampilkan masking 
        ROI_kanan1aa = maskH2a.*double(ROI_kanan1a); % mengalikan maskH2a dengan ROI_kanan1a

        crop_L1e=adapthisteq(ROI_kanan1aa); % melakukan histogram equalizer
        crop_L1eb = graythresh(crop_L1e); % mengubah citra menjadi citra biner
        mask_L11e=crop_L1eb.*double(ROI_kanan1aa); % mengalikan crop_L1eb dengan ROI_kanan1aa

        maxim=200; % menetapkan nilai grayscale maksimum senilai 200
        ukur1=sum(sum(double(ROI_kanan1a))); % menghitung nilai ROI
        fraksi1=sum(sum(mask_L11e))/(ukur1*maxim); % menghitung fraksi

        %ROI kanan-2
        message = sprintf('Select ROI 2 from\nthe right Condylus mandibulae');
        uiwait(msgbox(message));
        H3a = minus(mask1,mean_kanan2);
        maskH3a=double(H3a);
        maskH3a=maskH3a(:,:,1);

        cla(handles.axes8);
        imshow(H3a, 'Parent', handles.axes8)
        ROI_kanan2 = imfreehand(handles.axes8);
        ROI_kanan2a = createMask(ROI_kanan2); 
        ROI_kanan2aa = maskH3a.*double(ROI_kanan2a);

        crop_L2e=adapthisteq(ROI_kanan2aa);
        crop_L2eb = graythresh(crop_L2e);
        mask_L12e=crop_L2eb.*double(ROI_kanan2aa);

        maxim=200;
        ukur2=sum(sum(double(ROI_kanan2a)));
        fraksi2=sum(sum(mask_L12e))/(ukur2*maxim);

        %ROI kanan-3
        message = sprintf('Select ROI 3 from\nthe right Condylus mandibulae');
        uiwait(msgbox(message));
        H4a = minus(mask1,mean_kanan3);
        maskH4a=double(H4a);
        maskH4a=maskH4a(:,:,1);

        cla(handles.axes8);
        imshow(H4a, 'Parent', handles.axes8)
        ROI_kanan3 = imfreehand(handles.axes8);
        ROI_kanan3a = createMask(ROI_kanan3); 
        ROI_kanan3aa = maskH4a.*double(ROI_kanan3a);

        crop_L3e=adapthisteq(ROI_kanan3aa);
        crop_L3eb = graythresh(crop_L3e);
        mask_L13e=crop_L3eb.*double(ROI_kanan3aa);

        maxim=200;
        ukur3=sum(sum(double(ROI_kanan3a)));
        fraksi3=sum(sum(mask_L13e))/(ukur3*maxim);
        
% Processing ROI (left)

        %ROI kiri-1
        message = sprintf('Select ROI 1 from\nthe left Condylus mandibulae');
        uiwait(msgbox(message));
        
        H5a = minus(mask2,mean_kiri1);
        maskH5a=double(H5a);
        maskH5a=maskH5a(:,:,1);

        cla(handles.axes9);
        imshow(H5a, 'Parent', handles.axes9)
        ROI_kiri1 = imfreehand(handles.axes9);
        ROI_kiri1a = createMask(ROI_kiri1);
        ROI_kiri1aa = maskH5a.*double(ROI_kiri1a);

        crop_L4e=adapthisteq(ROI_kiri1aa);
        crop_L4eb = graythresh(crop_L4e);
        mask_L14e=crop_L4eb.*double(ROI_kiri1aa);

        maxim=200;
        ukur4=sum(sum(double(ROI_kiri1a)));
        fraksi4=sum(sum(mask_L14e))/(ukur4*maxim);

        %ROI kiri-2
        message = sprintf('Select ROI 2 from\nthe left Condylus mandibulae');
        uiwait(msgbox(message));
        
        H6a = minus(mask2,mean_kiri2);
        maskH6a=double(H6a);
        maskH6a=maskH6a(:,:,1);

        cla(handles.axes9);
        imshow(H6a, 'Parent', handles.axes9)
        ROI_kiri2 = imfreehand(handles.axes9);
        ROI_kiri2a = createMask(ROI_kiri2);
        ROI_kiri2aa = maskH6a.*double(ROI_kiri2a);

        crop_L5e=adapthisteq(ROI_kiri2aa);
        crop_L5eb = graythresh(crop_L5e);
        mask_L15e=crop_L5eb.*double(ROI_kiri2aa);

        maxim=200;
        ukur5=sum(sum(double(ROI_kiri2a)));
        fraksi5=sum(sum(mask_L15e))/(ukur5*maxim);

        %ROI kiri-3
        message = sprintf('Select ROI 3 from\nthe left Condylus mandibulae');
        uiwait(msgbox(message));
        
        H7a = minus(mask2,mean_kiri3);
        maskH7a=double(H7a);
        maskH7a=maskH7a(:,:,1);

        cla(handles.axes9);
        imshow(H7a, 'Parent', handles.axes9)
        ROI_kiri3 = imfreehand(handles.axes9);
        ROI_kiri3a = createMask(ROI_kiri3);
        ROI_kiri3aa = maskH7a.*double(ROI_kiri3a);

        crop_L6e=adapthisteq(ROI_kiri3aa);
        crop_L6eb = graythresh(crop_L6e);
        mask_L16e=crop_L6eb.*double(ROI_kiri3aa);

        maxim=200;
        ukur6=sum(sum(double(ROI_kiri3a)));
        fraksi6=sum(sum(mask_L16e))/(ukur6*maxim);
        
        FraksiR = [fraksi1, fraksi2, fraksi3];
        FraksiL = [fraksi4, fraksi5, fraksi6];
        Fraksi = [FraksiR, FraksiL];
        
% Classification
        Classif = load('SVM_6_37.mat');
        Validasi = svmclassify(Classif.Pelatihan1, Fraksi);
        
        if Validasi == 1
            Prediksi = 'Normal';
        else
            Prediksi = 'Osteoporosis'; 
        end

% Display fraction        
        
message = sprintf('Fraksi kanan-1 = %.3f\nFraksi kanan-2 = %.3f\nFraksi kanan-3 = %.3f\nFraksi kiri-1  = %.3f\nFraksi kiri-2  = %.3f\nFraksi kiri-3  = %.3f\nPrediksi status kesehatan tulang  = %s', ...
fraksi1, fraksi2, fraksi3, fraksi4, fraksi5, fraksi6, Prediksi);
msgbox(message);


        
% --- Executes on button press in back.
function back_Callback(hObject, eventdata, handles)
% hObject    handle to back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

        
        guidata(hObject, handles);
        


% --- Executes on button press in back.
function analyze_Callback(hObject, eventdata, handles)
% hObject    handle to back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
        cla(handles.axes1);
        cla(handles.axes8);
        cla(handles.axes9);
guidata(hObject, handles);


% --- Executes on button press in help.
function help_Callback(hObject, eventdata, handles)
% hObject    handle to help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
message = sprintf('1. -Select right Condylus mandibulae-\n   Klik kiri dan tahan untuk membuat kotak di sekitar\n   Condylus mandibulae kanan, lalu lepaskan\n\n2. -Select left Condylus mandibulae-\n   Klik kiri dan tahan untuk membuat kotak di sekitar\n   Condylus mandibulae kiri, lalu lepaskan\n\n3. -Select Background from the right Condylus mandibulae-\n   Klik kiri dan tahan untuk memilih background dari Condylus\n   mandibulae kanan. Apabila background sudah terlingkupi,\n   lepaskan mouse.\n   Pemilihan background akan diulangi sebanyak tiga kali.\n\n4. -Select Background from the left Condylus mandibulae-\n   Klik kiri dan tahan untuk memilih background dari Condylus\n   mandibulae kiri. Apabila background sudah terlingkupi,\n   lepaskan mouse.\n   Pemilihan background akan diulangi sebanyak tiga kali.\n\n5. -Select ROI from the right Condylus mandibulae-\n   Klik kiri dan tahan untuk memilih ROI dari Condylus\n   mandibulae kanan. Apabila ROI sudah terlingkupi, lepaskan mouse.\n   Pemilihan ROI akan diulangi sebanyak tiga kali.\n\n6. -Select ROI from the left Condylus mandibulae-\n   Klik kiri dan tahan untuk memilih ROI dari Condylus\n   mandibulae kiri. Apabila ROI sudah terlingkupi, lepaskan mouse.\n   Pemilihan ROI akan diulangi sebanyak tiga kali.');
uiwait(msgbox(message));

guidata(hObject, handles);

