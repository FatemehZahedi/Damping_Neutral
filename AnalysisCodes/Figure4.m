
%%-----------------------------------------------------------------
clc
clear
close all

AVE_tave = [100; 94.73; 87.5; 75.28; 62.49];
STD = [100-100; 97.727-91.726; 93.486-81.501; 81.37-69.19; 70.403-54.584]/2;

clear y error
dir={'0'; '-10'; '-15'; '-20'; '-25'};
dir1=[1 2 3 4 5];
%figure
subplot(2,2,2)
bar(dir1,diag(AVE_tave),'stacked')
set(gca, 'XTickLabel',dir, 'XTick',1:numel(dir))
y=AVE_tave;
error= STD;
ngroups = size(y, 1);
nbars = size(y, 2);
% Calculating the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));
hold on
for i = 1:nbars
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x,y(:,i),error(:,i) , '.k');
end
%ylabel('Success rate %')
title('ML');
axis([0 6 0 105])
set(gca,'FontSize',10)
box off
%-------------------------------------------------------------------------------------------

AVE_tave = [100; 99.17; 96.95; 86.4; 64.43];
STD = [100-100; 100.116-98.224; 98.863-95.037; 91.466-81.328; 73.062-55.798]/2;

clear y error
dir={'0'; '-20'; '-30'; '-40'; '-50'};
dir1=[1 2 3 4 5];
%figure
subplot(2,2,1)
bar(dir1,diag(AVE_tave),'stacked')
set(gca, 'XTickLabel',dir, 'XTick',1:numel(dir))
y=AVE_tave;
error= STD;
ngroups = size(y, 1);
nbars = size(y, 2);
% Calculating the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));
hold on
for i = 1:nbars
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x,y(:,i),error(:,i) , '.k');
end
ylabel('Success rate %')
title('AP');
axis([0 6 0 105])
set(gca,'FontSize',10)
box off

%%-------------------------------------------------------------------------------------------

AVE_tave = [1.011; 1.095; 1.306; 1.64; 2.069];
STD = [1.091-0.93; 1.163-1.027; 1.408-1.204; 1.781-1.498; 2.238-1.899]/2;

clear y error
dir={'0'; '-20'; '-30'; '-40'; '-50'};
dir1=[1 2 3 4 5];
%figure
subplot(2,2,3)
bar(dir1,diag(AVE_tave),'stacked')
set(gca, 'XTickLabel',dir, 'XTick',1:numel(dir))
y=AVE_tave;
error= STD;
ngroups = size(y, 1);
nbars = size(y, 2);
% Calculating the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));
hold on
for i = 1:nbars
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x,y(:,i),error(:,i) , '.k');
end
% x_new=[1 2 3 4 5]';
% [c,S]=polyfit(x_new,y,1);
% R2(2)=1-(S.normr/norm(y-mean(y)))^2;
% y_est = polyval(c,x_new);
% plot(x_new,y_est,'-r');
xlabel('Damping (Ns/m)');
ylabel('Time to regain stability (sec)')
axis([0 6 0 2.5])
set(gca,'FontSize',10)
box off

AVE_tave = [1.314; 1.477; 1.646; 1.935; 2.131];
STD = [1.393-1.235; 1.582-1.372; 1.778-1.515; 2.068-1.803; 2.277-1.986]/2;

clear y error
dir={'0'; '-10'; '-15'; '-20'; '-25'};
dir1=[1 2 3 4 5];
%figure
subplot(2,2,4)
bar(dir1,diag(AVE_tave),'stacked')
set(gca, 'XTickLabel',dir, 'XTick',1:numel(dir))
y=AVE_tave;
error= STD;
ngroups = size(y, 1);
nbars = size(y, 2);
% Calculating the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));
hold on
for i = 1:nbars
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x,y(:,i),error(:,i) , '.k');
end
% x_new=[1 2 3 4 5]';
% [c,S]=polyfit(x_new,y,1);
% y_est = polyval(c,x_new);
% R2(1)=1-(S.normr/norm(y-mean(y)))^2;
% plot(x_new,y_est,'-r');
xlabel('Damping (Ns/m)');
%ylabel('Time to regain stability (sec)')
axis([0 6 0 2.5])
set(gca,'FontSize',10)
box off
annotation('textbox', [0, 0.5, 0, 0], 'string', 'B','fontweight','bold','fontsize',14)
annotation('textbox', [0, 0.95, 0, 0], 'string', 'A','fontweight','bold','fontsize',14)