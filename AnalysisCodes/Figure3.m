clear 
clc
close all

load('position.mat');
filename = 'C:\Users\fzahedi1admin\OneDrive - Arizona State University\Projects\Damping Map\Experiments\Test\Neutral\Data\Subject14\Subject14_1.mat';
load(filename);
m=cel{1};
clear m

for i=1:12
    
    str1 = ['C:\Users\fzahedi1admin\OneDrive - Arizona State University\Projects\Damping Map\Experiments\Test\Neutral\Data\Subject14\Subject14_',num2str(i),'.mat'];
    data = load(str1);
    
    clear cel
    load(str1);

    for j=1:size(cel,2)

      
      if size(cel{j},1)~= 0
        clear m
        m=cel{j};

        M1(:,:,i,j) = m;
        
      end

    end

end

time=-1000:length(M1(1,:,1,1))-1001;
j=8;
figure
for i=1:size(Position,2)
    clear pos_draw
    if j==8 || j==6 || j==4 || j==2
        j1=j-1;
    else
        j1=j+1;
    end
    if j1==1
        j1=3;
    elseif j1==2
        j1=4;
    elseif j1==3
        j1=1;
    elseif j1==4
        j1=2;
    end
    subplot(4,2,j1)
    
    j=j-1;
%     if i==1
%         i=3;
%         desired=0;
%     elseif i==2
%         i=4;
%     elseif i==3
%         i=1;
%     elseif i==4
%         i=2;
    if i<5
        desired=0; 
    elseif i>=5
        desired=0.76;
    end
    
    pos_draw = Position{i};
    plot(time*0.001,pos_draw-desired,'color',[0.7 0.7 0.7]);
    hold on
    plot(time*0.001,mean(pos_draw-desired,1),'k');
    if i==1 || i==3 || i==5 || i==7
        ylabel('Position (m)');
    end
    box off
%     if i==3 || i==4
%         axis([-1000 3000 -0.1 0.1]);
%     elseif i==1 || i==2
%         axis([-1000 3000 -0.1 0.05]);
%     elseif i==5 || i==6
%         axis([-1000 3000 0.65 0.85]);
%     else
%        axis([-1000 3000 0.65 0.9]);
%     end
 axis([-1 3 -0.15 0.15]);
    if i==5
        title('Neutral');
    elseif i==6
        title('Unstable');
    elseif i==1 || i==2
        xlabel('Time (sec)');
    end
    set(gca,'FontSize',10)
    annotation('textbox', [0.01, 0.95, 0, 0], 'string', 'A','fontweight','bold')%,'fontsize',12)
    annotation('textbox', [0.01, 0.7, 0, 0], 'string', 'B','fontweight','bold')%,'fontsize',12)
    annotation('textbox', [0.01, 0.5, 0, 0], 'string', 'C','fontweight','bold')%,'fontsize',12)
    annotation('textbox', [0.01, 0.3, 0, 0], 'string', 'D','fontweight','bold')%,'fontsize',12)
end