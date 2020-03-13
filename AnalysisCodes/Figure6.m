clc
clear
close all

AVE_tave = [0.93; 0.944; 0.947; 0.953; 0.955];
STD = [0.939-0.922; 0.951-0.937; 0.953-0.94; 0.96-0.946; 0.961-0.948]/2;

clear y error
dir={'0'; '-10'; '-15'; '-20'; '-25'};
dir1=[1 2 3 4 5];
%figure
subplot(1,2,2)
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
plot([1-0.15; 2-0.15], y(1:2)+0.01,'r')
plot([2; 5], [y(2); y(5)]+0.011,'r')
%ylabel('Eigenvalue')
title('ML');
axis([0 6 0.8 1])
set(gca,'FontSize',10)
xlabel('Damping (Ns/m)');
box off

%-------------------------------------------------------------------------------------------

AVE_tave = [0.88; 0.901; 0.916; 0.923; 0.932];
STD = [0.897-0.862; 0.917-0.886; 0.923-0.903; 0.935-0.91; 0.943-0.92]/2;

clear y error
dir={'0'; '-20'; '-30'; '-40'; '-50'};
dir1=[1 2 3 4 5];
%figure
subplot(1,2,1)
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
plot([1-0.15; 3-0.15], [y(1); y(3)]+0.02,'r')
plot([3; 5], [y(3); y(5)]+0.022,'r')
ylabel('Eigenvalue')
title('AP');
axis([0 6 0.8 1])
set(gca,'FontSize',10)
xlabel('Damping (Ns/m)');
box off
