close all
clear
clc

% %should be written in command window before running
% w={};
% save fail_subject1.mat w;

nf=12;
filename = 'C:\Users\fzahedi1admin\OneDrive - Arizona State University\Projects\Damping Map\Experiments\Test\Neutral\Data\Subject21\KD_S21_B12.txt';
data1=load(filename);

% % filename = 'C:\Users\fzahedi1admin\OneDrive - Arizona State University\Projects\Damping Map\Experiments\Test\Neutral\Data\Subject15\KD_S15_B8_2.txt';
% % data2=load(filename);
% % 
% % n_v2 = data2(1,23);
% % 
% % ind_repeat2 = find(data1(:,23) == n_v2);
% % 
% % filename = 'C:\Users\fzahedi1admin\OneDrive - Arizona State University\Projects\Damping Map\Experiments\Test\Neutral\Data\Subject15\KD_S15_B8_3.txt';
% % data3=load(filename);
% % 
% % n_v3 = data3(1,23);
% % 
% % ind_repeat3 = find(data2(:,23) == n_v3);
% % 
% % filename = 'C:\Users\fzahedi1admin\OneDrive - Arizona State University\Projects\Damping Map\Experiments\Test\Neutral\Data\Subject15\KD_S15_B8.txt';
% % data4=load(filename);
% % 
% % n_v4 = data4(1,23);
% % 
% % ind_repeat4 = find(data3(:,23) == n_v4);
% % 
% % data = [data1(1:ind_repeat2-1,:); data2(1:ind_repeat3-1,:); data3(1:ind_repeat4-1,:); data4];


% filename = 'C:\Users\fzahedi1admin\OneDrive - Arizona State University\Projects\Damping Map\Experiments\Test\Neutral\Data\Subject21\KD_S21_B11.txt';
% data2=load(filename);
% 
% n_v = data2(1,23);
% 
% ind_repeat = find(data1(:,23) == n_v);
% data = [data1(1:ind_repeat-1,:); data2];

data = data1;

alpha = [pi/2, -pi/2, -pi/2, pi/2, pi/2, -pi/2, 0];
a = [0, 0, 0, 0, 0, 0, 0];
d = [0.36, 0, 0.42, 0, 0.4, 0, 0.126];
theta=[0 0 0 0 0 0 -0.958709];
dh = [theta' d' a' alpha'];
h=0.001;
s=2000;

% BUILD ROBOT--------------------------------------------------------------
for i = 1:length(dh(:,1))
    L{i} = Link('d', dh(i,2), 'a', dh(i,3), 'alpha', dh(i,4));
end
rob = SerialLink([L{1} L{2} L{3} L{4} L{5} L{6} L{7}]);

qm= data(:,2:7)';

ind1= data(s+1:end,18);
ind2= data(s+1:end,19);

ind_trig = data(s+1:end,22);

ind_ind = data(s+1:end,23);

ind_pert = data(s+1:end,24);

ind_fail = data(s+1:end,25);

for i=1:length(qm)
    theta=[qm(:,i)' -0.958709]; %This should be in both ways
    [T,all] = rob.fkine(theta);
    phi_euler = atan2(T(2, 3), T(1, 3));
    theta_euler = atan2(sqrt(T(2, 3)^2 + T(1, 3)^2), T(3, 3));
    psi_euler = atan2(T(3, 2), -T(3, 1));
    xm1(:,i)=[T(1,4) T(2,4) T(3,4) phi_euler theta_euler psi_euler]';
    %[Ja,x(:,i)]=Jacobian(alpha,a,d,theta);
end
%xm1=data(:,3:8)';
xm=xm1(:,s+1:end);

d1 = designfilt('lowpassiir','FilterOrder',12,'HalfPowerFrequency',20,'DesignMethod','butter','Samplerate',1000);

for i=1:size(xm,1)
    xm(i,:)=filtfilt(d1,xm(i,:));
end

j=1;
%figure
% for i=1:2:3
%     %subplot(1,2,j)
%     figure
%     subplot(2,1,1)
%     plot(xm(i,:));
%     ylabel('x');
%     grid on
%     subplot(2,1,2)
%     plot(ind);
%     grid on
%     ylabel('damping value');
%     j=j+1;
%     xlabel('Time (ms)');
% end

ind_tn = find(ind_trig == 0);

ind_failure = find(ind_fail == 1);

fail = ind_ind(ind_failure);

for i=1:length(fail)
    if fail(i) <= 10
        if rem(fail(i),5)==0
            failure(i,:)=[rem(fail(i),5)+5 ind1(ind_failure(i)) ind_pert(ind_failure(i))];
        else 
            failure(i,:)=[rem(fail(i),5) ind1(ind_failure(i)) ind_pert(ind_failure(i))];
        end
    else
        if rem(fail(i),5)==0
            failure(i,:)=[rem(fail(i),5)+5 ind2(ind_failure(i)) ind_pert(ind_failure(i))];
        else 
            failure(i,:)=[rem(fail(i),5) ind2(ind_failure(i)) ind_pert(ind_failure(i))];
        end
    end
end


if length(fail)==0
    failure = [];
end

j=1;
n=1;
for i=1:length(ind_tn)
    if i < length(ind_tn)
        if ind_tn(i+1)-ind_tn(i) > 1
            clear new
            new=[xm(:,ind_tn(j)-1000:ind_tn(i)+3000); ind1(ind_tn(j)-1000:ind_tn(i)+3000)'; ind2(ind_tn(j)-1000:ind_tn(i)+3000)'; ind_ind(ind_tn(j)-1000:ind_tn(i)+3000)'; ind_pert(ind_tn(j)-1000:ind_tn(i)+3000)'];
            content{n}=new;
            n=n+1;
            j = i+1;
        end
    end
    if i==length(ind_tn)
        clear new
        new=[xm(:,ind_tn(j)-1000:ind_tn(i)+3000); ind1(ind_tn(j)-1000:ind_tn(i)+3000)'; ind2(ind_tn(j)-1000:ind_tn(i)+3000)'; ind_ind(ind_tn(j)-1000:ind_tn(i)+3000)'; ind_pert(ind_tn(j)-1000:ind_tn(i)+3000)'];
        content{n}=new;
    end
end

for i=1:size(content,2)
    clear m
    m=content{i};
    cel{m(end-1,1)}=content{i};
end

for i=1:length(fail)
    cel{fail(i)}=[];
end

 
save Subject21_12.mat cel


load('fail_subject21.mat');
failtest{nf}=failure;
save fail_subject21.mat failtest