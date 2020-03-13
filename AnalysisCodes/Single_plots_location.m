% Single plot for each location

clc
clear
close all



filename = 'C:\Users\fzahedi1admin\OneDrive - Arizona State University\Projects\Damping Map\Experiments\Test\Neutral\Data\Subject8\Subject8_1.mat';
load(filename);
m=cel{1};
clear m

for i=1:12
    
    str1 = ['C:\Users\fzahedi1admin\OneDrive - Arizona State University\Projects\Damping Map\Experiments\Test\Neutral\Data\Subject8\Subject8_',num2str(i),'.mat'];
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

load('position.mat');

sn=5;
for k=0:3
    figure
    if k==0
       t=suptitle('Right');
       t.FontSize=12; 
    elseif k==1
        t=suptitle('Left');
        t.FontSize=12;
    elseif k==2
        t=suptitle('Down');
        t.FontSize=12;
    elseif k==3
        t=suptitle('Up');
        t.FontSize=12;
    end
    t.FontSize=12;
    
    for j=1:5
        clear M me1
        subplot(5,1,j);
        if k==0 || k==1
              for l=1:size(M1,3)
                  M(l,:)=M1(1,:,l,5*k+j);
              end
        else
              for l=1:size(M1,3)
                  M(l,:)=M1(3,:,l,5*k+j);
              end
        end
        M(~any(M,2),:)=[];
        for i=1:size(M,1)
            hold on
            plot(time,M(i,:),'Color',[0.7 0.7 0.7]);
            grid on
        end
        if (j==1 || j==5)&&(k==2 || k==3)
        Position{sn}=M;
        sn=sn+1;
        end
        me1 = mean(M,1);
        hold on
        plot(time,me1,'k');
        
        if k==0
                axis([-1000 4000 -0.15 0.1]);
        elseif k==1 
                axis([-1000 4000 -0.08 0.13]);
        elseif k==2
                 axis([-1000 4000 0.62 0.9]);
        elseif k==3
                 axis([-1000 4000 0.60 0.89]);
        end
      
        ylabel('x (m)');
          if j==5
              xlabel('Time (ms)');
          end
          if k==0 || k==1
          index = find(M1(end-3,end,:,5*k+j));
          if isempty(index)
            str = sprintf('Damping = %d Ns/m', M1(end-3,end,end,5*k+j));
          else
            str = sprintf('Damping = %d Ns/m', M1(end-3,end,index(1),5*k+j));
          end
      else
          index = find(M1(end-2,end,:,5*k+j));
          if isempty(index)
            str = sprintf('Damping = %d Ns/m', M1(end-2,end,end,5*k+j));
          else
            str = sprintf('Damping = %d Ns/m', M1(end-2,end,index(1),5*k+j));
          end
      end
          t1=title(str);
          t1.FontSize=8;
    end
end
save position.mat Position

j=8;
figure
for i=1:size(Position,2)
    clear pos_draw
    if j==8 || j==6 || j==4 || j==2
        j1=j-1;
    else
        j1=j+1;
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
 axis([-1 3 -0.12 0.12]);
    if i==7
        title('Stable');
    elseif i==8
        title('Unstable');
    elseif i==3 || i==4
        xlabel('Time (sec)');
    end
    annotation('textbox', [0.01, 0.95, 0, 0], 'string', 'A','fontweight','bold')%,'fontsize',12)
    annotation('textbox', [0.01, 0.7, 0, 0], 'string', 'B','fontweight','bold')%,'fontsize',12)
    annotation('textbox', [0.01, 0.5, 0, 0], 'string', 'C','fontweight','bold')%,'fontsize',12)
    annotation('textbox', [0.01, 0.3, 0, 0], 'string', 'D','fontweight','bold')%,'fontsize',12)
end

      