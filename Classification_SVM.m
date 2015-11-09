clear
clc

[num1,txt1]=xlsread('Data_SVM_Baru_CV.xlsx',1); % Membuka file excel data latih
[num2,txt2]=xlsread('Data_SVM_Baru_CV.xlsx',6);

% Identitas data validasi
n = 37; % Awal: 1, 10, 19, 28, 37
m = n-1;

% Plot sebaran data fitur

FraksiRn = zeros(34,1);
FraksiLn = zeros(34,1);

for i=1:34
    FraksiRn(i,:) = num2(i,11);
    FraksiLn(i,:) = num2(i,12);
end

FraksiRo = zeros(11,1);
FraksiLo = zeros(11,1);

for i=35:45
    FraksiRo(i-34,:) = num2(i,11);
    FraksiLo(i-34,:) = num2(i,12);
end

figure(1);
plot(FraksiRn,FraksiLn,'g.');
xlabel('\fontsize{15}Fraksi kanan'); 
ylabel('\fontsize{15}Fraksi kiri');
title('\fontsize{18}Sebaran Fitur');
hold on;
plot(FraksiRo,FraksiLo,'r*');
hold off;


% Membuat matriks data latih

if n == 1

     Fraksi1 = zeros(36,6);
    
    for i = 10:45
        Fraksi1(i-9,1:6) = num1(i,5:10); % Input data latih
    end
    
elseif n == 10
    
    Fraksi1 = zeros(36,6);
    
    for i = 1:9
        Fraksi1(i,1:6) = num1(i,5:10); % Input data latih
    end
    for i = 19:45
        Fraksi1(i-9,1:6) = num1(i,5:10); % Input data latih
    end
    
elseif n == 19
    
    Fraksi1 = zeros(36,6);
    
    for i = 1:18
        Fraksi1(i,1:6) = num1(i,5:10); % Input data latih
    end
    for i = 28:45
        Fraksi1(i-9,1:6) = num1(i,5:10); % Input data latih
    end 
    
elseif n == 28
    
    Fraksi1 = zeros(36,6);
    
    for i = 1:18
        Fraksi1(i,1:6) = num1(i,5:10); % Input data latih
    end
    for i = 28:45
        Fraksi1(i-9,1:6) = num1(i,5:10); % Input data latih
    end 
    
elseif n == 37
    
     Fraksi1 = zeros(36,6);
    
    for i = 1:36
        Fraksi1(i,1:6) = num1(i,5:10); % Input data latih
    end
    
else
    sprintf('ERROR! Data harus dibagi sama rata.') 
end


% Menggunakan rata-rata

if n == 1

     FraksiRata = zeros(36,2);
    
    for i = 10:45
        FraksiRata(i-9,1:2) = num1(i,11:12); % Input data latih
    end
    
elseif n == 10
    
    FraksiRata = zeros(36,2);
    
    for i = 1:9
        FraksiRata(i,1:2) = num1(i,11:12); % Input data latih
    end
    for i = 19:45
        FraksiRata(i-9,1:2) = num1(i,11:12); % Input data latih
    end
    
elseif n == 19
    
    FraksiRata = zeros(36,2);
    
    for i = 1:18
        FraksiRata(i,1:2) = num1(i,11:12); % Input data latih
    end
    for i = 28:45
        FraksiRata(i-9,1:2) = num1(i,11:12); % Input data latih
    end 
    
elseif n == 28
    
    FraksiRata = zeros(36,2);
    
    for i = 1:18
        FraksiRata(i,1:2) = num1(i,11:12); % Input data latih
    end
    for i = 28:45
        FraksiRata(i-9,1:2) = num1(i,11:12); % Input data latih
    end 
    
elseif n == 37
    
     FraksiRata = zeros(36,2);
    
    for i = 1:36
        FraksiRata(i,1:2) = num1(i,11:12); % Input data latih
    end
    
else
    sprintf('ERROR! Data harus dibagi sama rata.') 
end

% Menggunakan array

FraksiR = [Fraksi1(:,1);Fraksi1(:,2);Fraksi1(:,3)];
FraksiL = [Fraksi1(:,4);Fraksi1(:,5);Fraksi1(:,6)];

Fraksi = [FraksiR, FraksiL];



% Membuat matriks kelas latih

if n == 1

     Kelas1 = zeros(36,1);
    
    for i = 10:45
        Kelas1(i-9,1) = num1(i,4); % Input data latih
    end
    
elseif n == 10
    
     Kelas1 = zeros(36,1);
    
    for i = 1:9
        Kelas1(i,1) = num1(i,4); % Input data latih
    end
    for i = 19:45
        Kelas1(i-9,1) = num1(i,4); % Input data latih
    end
    
elseif n == 19
    
     Kelas1 = zeros(36,1);
    
    for i = 1:18
        Kelas1(i,1) = num1(i,4); % Input data latih
    end
    for i = 28:45
        Kelas1(i-9,1) = num1(i,4); % Input data latih
    end 
    
elseif n == 28
    
     Kelas1 = zeros(36,1);
    
    for i = 1:18
        Kelas1(i,1) = num1(i,4); % Input data latih
    end
    for i = 28:45
        Kelas1(i-9,1) = num1(i,4); % Input data latih
    end 
    
elseif n == 37
    
      Kelas1 = zeros(36,1);
    
    for i = 1:36
        Kelas1(i,1) = num1(i,4); % Input data latih
    end
    
else
    sprintf('ERROR! Data harus dibagi sama rata.') 
end

% Menggunakan array

Kelas = [Kelas1(:,:);Kelas1(:,:);Kelas1(:,:)];

% SVM training

Pelatihan1 = svmtrain(Fraksi1, Kelas1, 'kernel_function', 'linear');

figure(2);
Pelatihan = svmtrain(Fraksi, Kelas, 'kernel_function', 'linear', 'showplot', true);

figure(3);
PelatihanR = svmtrain(FraksiRata, Kelas1, 'kernel_function', 'linear', 'showplot', true);


% Membuat matriks data validasi

Fraksi2 = zeros(9,6); % Membuat template matriks berukuran sesuai dengan jumlah data validasi supaya waktu komputasi lebih cepat
                      % zeros(banyak data latih,1)

for i = 1:9;
        Fraksi2(i,1:6) = num1(i+m,5:10); % Input data latih fraksi kanan
end

% Menggunakan rata-rata

FraksiRata2 = zeros(9,2);

for i = 1:9;
        FraksiRata2(i,1:2) = num1(i+m,11:12); % Input data latih fraksi kanan
end

% Menggunakan array

FraksiR2 = [Fraksi2(:,1);Fraksi2(:,2);Fraksi2(:,3)];
FraksiL2 = [Fraksi2(:,4);Fraksi2(:,5);Fraksi2(:,6)];

Fraksi22 = [FraksiR2, FraksiL2];

% Validasi SVM
Validasi1 = svmclassify(Pelatihan1, Fraksi2);

Validasi = svmclassify(Pelatihan, Fraksi22,'showplot',true);
xlabel('\fontsize{15}Fraksi kanan'); 
ylabel('\fontsize{15}Fraksi kiri');
title('\fontsize{18}Hasil Klasifikasi (Array)');

ValidasiR = svmclassify(PelatihanR, FraksiRata2, 'showplot',true);
xlabel('\fontsize{15}Fraksi kanan'); 
ylabel('\fontsize{15}Fraksi kiri');
title('\fontsize{18}Hasil Klasifikasi');

save SVM_6_37 Pelatihan1
