clear;
clc;

nclass = 1; % number of normal patient
sclass = 2; % number of ill patient

for taylor = 1:sclass
    statname='Osteoporosis';
    for jj = 1:sclass
        filename
        impath=sprintf('C:\\Users\\AsusPC\\Dropbox\\Kuliah\\Research_Osteoporosis\\Data\\Images\\Data_1\\%s\\S%d.tif'...
            ,statname,jj); % automatic name
        
        if exist(impath, 'file') == 2
            F = double(imread(impath));
            [ysize,xsize,col] = size(F);
            
            if col == 3
                F = rgb2gray(F./255);
            end
            
            Fcrop = F(1:end/2, :);
            
        end
        
        figure(taylor);
        subplot(2,1,1), imshow(impath); % automatic open
        subplot(2,1,2), imshow(Fcrop);
        
    end
    
    
    
    
    
    
    
    % for status = 1
    %
    %     statname='Normal';
    %
    %     for jj = 1 : nclass
    %         impath=sprintf('C:\\Users\\AsusPC\\Dropbox\\Kuliah\Research_Osteoporosis\\Data\\Images\\Data_1\\%s%d\\N%d.tif',statname,jj); % automatic name
    %     end
    %
    % end
    % for status = 2
    %
    %     for jj = 1 : sclass
    %         statname='Osteoporosis';
    %     end
    %
    %     impath=sprintf('C:\Users\AsusPC\Dropbox\Kuliah\Research_Osteoporosis\Data\Images\Data_1\%s%d\S%d.tif',statname,jj); % automatic name
    % end
    %
    % imlist=dir(impath); % automatic open
    
    
