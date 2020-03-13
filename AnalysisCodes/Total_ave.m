clc
clear
close all


load('Average_rate_total.mat');
load('Average_time_total.mat');



for i=1:size(rate_total,1)
    clear M Q
    M(:,:)=rate_total(i,:,:);
    Q=M';
    AVE_rate(i,:)=mean(Q,1);
    STD_rate(i,:)=std(Q);
end

for i=1:size(tave_total,1)
    clear M Q
    M(:,:)=tave_total(i,:,:);
    Q=M';
    AVE_tave(i,:)=mean(Q,1);
    STD_tave(i,:)=std(Q);
end


%dir={'right'; 'left'};
dir={'lateral'; 'medial'};
dir1=[1 2];
figure
subplot(2,2,1)
bar(dir1,AVE_rate(:,1:2)')
set(gca, 'XTickLabel',dir, 'XTick',1:numel(dir))
ngroups = size(AVE_rate(:,1:2)', 1);
nbars = size(AVE_rate(:,1:2)', 2);
% Calculating the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));
hold on
y=AVE_rate(:,1:2)';
error= STD_rate(:,1:2)';
for i = 1:nbars
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x,y(:,i),error(:,i) , '.k');
end
axis([0 3 0 110])
%legend('0','-10','-15','-20','-25')
xlabel('Direction');
ylabel('success rate %')
title('ML');
annotation('textbox', [0, 0.95, 0, 0], 'string', 'A','fontweight','bold','fontsize',14)


clear y error

% dir={'down'; 'up'};
dir={'posterior'; 'anterior'};
dir1=[1 2];
subplot(2,2,2)
bar(dir1,AVE_rate(:,3:4)')
set(gca, 'XTickLabel',dir, 'XTick',1:numel(dir))
y=AVE_rate(:,3:4)';
error= STD_rate(:,3:4)';
ngroups = size(y, 1);
nbars = size(y, 2);
% Calculating the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));
hold on
for i = 1:nbars
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x,y(:,i),error(:,i) , '.k');
end
axis([0 3 0 110])
%legend('0','-20','-30','-40','-50')
xlabel('Direction');
ylabel('success rate %')
title('AP');
annotation('textbox', [0, 0.5, 0, 0], 'string', 'B','fontweight','bold','fontsize',14)

clear y error
dir={'lateral'; 'medial'};
dir1=[1 2];
%figure
subplot(2,2,3)
bar(dir1,AVE_tave(:,1:2)')
set(gca, 'XTickLabel',dir, 'XTick',1:numel(dir))
y=AVE_tave(:,1:2)';
error= STD_tave(:,1:2)';
ngroups = size(y, 1);
nbars = size(y, 2);
% Calculating the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));
hold on
for i = 1:nbars
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x,y(:,i),error(:,i) , '.k');
end
c=polyfit([0.6923 0.8462 1 1.154 1.308],y(1,:),1);
y_est = polyval(c,[0.6923 0.8462 1 1.154 1.308]);
plot([0.6923 0.8462 1 1.154 1.308],y_est,'-r');
c=polyfit([1.692 1.846 2 2.154 2.308],y(2,:),1);
y_est = polyval(c,[1.692 1.846 2 2.154 2.308]);
plot([1.692 1.846 2 2.154 2.308],y_est,'-r');
legend('0','-10','-15','-20','-25')
xlabel('Direction');
ylabel('Average time to regain stability (ms)')
axis([0 3 0 3000])

clear y error
dir={'posterior'; 'anterior'};
dir1=[1 2];
subplot(2,2,4)
bar(dir1,AVE_tave(:,3:4)')
set(gca, 'XTickLabel',dir, 'XTick',1:numel(dir))
y=AVE_tave(:,3:4)';
error= STD_tave(:,3:4)';
ngroups = size(y, 1);
nbars = size(y, 2);
% Calculating the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));
hold on
for i = 1:nbars
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x,y(:,i),error(:,i) , '.k');
end
c=polyfit([0.6923 0.8462 1 1.154 1.308],y(1,:),1);
y_est = polyval(c,[0.6923 0.8462 1 1.154 1.308]);
plot([0.6923 0.8462 1 1.154 1.308],y_est,'-r');
c=polyfit([1.692 1.846 2 2.154 2.308],y(2,:),1);
y_est = polyval(c,[1.692 1.846 2 2.154 2.308]);
plot([1.692 1.846 2 2.154 2.308],y_est,'-r');
%legend('0','-10','-20','-30','-40')
legend('0','-20','-30','-40','-50')
xlabel('Direction');
ylabel('Average time to regain stability (ms)')
axis([0 3 0 3000])

