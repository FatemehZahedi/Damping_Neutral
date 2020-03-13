close all
clear
clc

filename = 'C:\Users\fzahedi1admin\OneDrive - Arizona State University\Projects\Damping Map\Experiments\Test\Neutral\Data\Subject21\Subject21_1.mat';
load(filename);
m=cel{1};

clear m

for i=1:12
    
    str1 = ['C:\Users\fzahedi1admin\OneDrive - Arizona State University\Projects\Damping Map\Experiments\Test\Neutral\Data\Subject21\Subject21_',num2str(i),'.mat'];
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


for i=0:3
    figure
    if i==0
       t=suptitle('Right');
       t.FontSize=12; 
    elseif i==1
        t=suptitle('Left');
        t.FontSize=12;
    elseif i==2
        t=suptitle('Down');
        t.FontSize=12;
    elseif i==3
        t=suptitle('Up');
        t.FontSize=12;
    end
    
    for j=1:5
       clear me1 st1 M index
      if i==0 || i==1
          for l=1:size(M1,3)
              M(l,:)=M1(1,:,l,5*i+j);
          end
      else
          for l=1:size(M1,3)
              M(l,:)=M1(3,:,l,5*i+j);
          end
      end
      M(~any(M,2),:)=[];
      me1 = mean(M,1);
      if size(M,1)==1
          st1 = 0;
      else
        st1 = std(M);
      end
      subplot(5,1,j);
      plot(time,me1,'k');
      hold on
      plot(time,me1+st1,'-.k');
      hold on
      plot(time,me1-st1,'--k');
      grid on
      
      if i==0
            axis([-1000 4000 -0.13 0.09]);
      elseif i==1 
            axis([-1000 4000 -0.09 0.13]);
      elseif i==2
             axis([-1000 4000 0.65 0.9]);
      elseif i==3
             axis([-1000 4000 0.62 0.85]);
      end
      
      ylabel('x (m)');
      if j==5
          xlabel('Time (ms)');
      end
      if i==0 || i==1
          index = find(M1(end-3,end,:,5*i+j));
          if isempty(index)
            str = sprintf('Damping = %d Ns/m', M1(end-3,end,end,5*i+j));
          else
            str = sprintf('Damping = %d Ns/m', M1(end-3,end,index(1),5*i+j));
          end
      else
          index = find(M1(end-2,end,:,5*i+j));
          if isempty(index)
            str = sprintf('Damping = %d Ns/m', M1(end-2,end,end,5*i+j));
          else
            str = sprintf('Damping = %d Ns/m', M1(end-2,end,index(1),5*i+j));
          end
      end
          
      t1=title(str);
      t1.FontSize=8;
        
    end     
end

