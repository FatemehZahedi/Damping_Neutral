close all
clear
clc

N_sub = 15;

% w={};
% save Average_rate_total.mat w;

% w={};
% save Average_time_total.mat w;

radius_e = 0.005;

filename = 'C:\Users\fzahedi1admin\OneDrive - Arizona State University\Projects\Damping Map\Experiments\Test\Neutral\Data\Subject21\Subject21_1.mat';
load(filename);

filename2 = 'C:\Users\fzahedi1admin\OneDrive - Arizona State University\Projects\Damping Map\Experiments\Test\Neutral\Data\Subject21\fail_subject21.mat';
load(filename2);

m=cel{1};
M1=zeros(size(m,1),size(m,2),3,20);
M2=zeros(size(m,1),size(m,2),3,20);
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

for i=0:3
    
    if i==0
        desired = 0;
    elseif i==1
        desired = 0;
    elseif i==2
        desired = 0.76;
    elseif i==3
        desired = 0.76;
    end
    
    for j=1:5
        
        clear M
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
        
        for k=1:size(M,1)
            
            clear E ind_t
            E = M(k,size(M,2)-3000+1:end)-desired;
            ind_t = find(abs(E) <= radius_e);
            
            q = 1;
            flag = 0;
            for f=1:length(ind_t)
                
                if f < length(ind_t) && flag == 0
                    
                    if ind_t(f+1)-ind_t(f) > 1
                        
                        e_length = f - q;
                        
                        if e_length >= 500
                            
                            t_re1(j,i+1,k) = ind_t(q);
                            t_re2(j,i+1,k) = ind_t(q);
                            success1(j,i+1,k) = 1;
                            flag = 1;
                        else
                            q = f+1;
                        end
                    end
                end
                
                if f == length(ind_t) && flag == 0
                    
                    e_length = f - q;
                    
                    if e_length >= 500
                        
                        t_re1(j,i+1,k) = ind_t(q);
                        t_re2(j,i+1,k) = ind_t(q);
                        success1(j,i+1,k) = 1;
                    
                    else
                       
                       t_re1(j,i+1,k)=0;
                       t_re2(j,i+1,k)=3000;
                       success1(j,i+1,k) = -1; 
                    end
                end
            end
        end
    end
end

ind_remove = find(t_re2==0);
t_re2(ind_remove)=3000;
t_ave = mean(t_re2,3);

success1(1,2,7)=1;
ex=size(success1,3);
for i=1:size(failtest,2)
    clear F
    F=failtest{i};
    for j=1:size(F,1)
        success1(F(j,1),F(j,end),i+ex) = -1;
    end
            
end
                        
for i=1:4
    for j=1:5
        
        rate1(j,i) = (size(find(success1(j,i,:)==1),1)/size(find(success1(j,i,:)),1))*100;
        %if rate1(j,i)==100
            max_time1(j,i)=max(t_re1(j,i,:));
%         else
%             max_time1(j,i)=3000;
%         end
    end
end

% dir={'right'; 'left'; 'down'; 'up'};
% dir1=[1 2 3 4];
% figure
% bar(dir1,rate1(:,1:4)')
% set(gca, 'XTickLabel',dir, 'XTick',1:numel(dir))
% axis([0 5 0 110])
% %legend('0','-10','-15','-20','-25')
% legend('0','-10','-20','-25','-30')
% xlabel('Direction');
% ylabel('success rate %')

dir={'right'; 'left'};
dir1=[1 2];
figure
subplot(1,2,1)
bar(dir1,rate1(:,1:2)')
set(gca, 'XTickLabel',dir, 'XTick',1:numel(dir))
axis([0 3 0 110])
legend('0','-10','-15','-20','-25')
xlabel('Direction');
ylabel('success rate %')

dir={'down'; 'up'};
dir1=[1 2];
subplot(1,2,2)
bar(dir1,rate1(:,3:4)')
set(gca, 'XTickLabel',dir, 'XTick',1:numel(dir))
axis([0 3 0 110])
legend('0','-20','-30','-40','-50')
xlabel('Direction');
ylabel('success rate %')

dir={'right'; 'left'};
dir1=[1 2];
figure
subplot(1,2,1)
bar(dir1,max_time1(:,1:2)')
set(gca, 'XTickLabel',dir, 'XTick',1:numel(dir))
legend('0','-10','-15','-20','-25')
xlabel('Direction');
ylabel('Max time to regain stability (ms)')
axis([0 3 0 3000])

dir={'down'; 'up'};
dir1=[1 2];
subplot(1,2,2)
bar(dir1,max_time1(:,3:4)')
set(gca, 'XTickLabel',dir, 'XTick',1:numel(dir))
legend('0','-20','-30','-40','-50')
xlabel('Direction');
ylabel('Max time to regain stability (ms)')
axis([0 3 0 3000])

dir={'right'; 'left'};
dir1=[1 2];
figure
subplot(1,2,1)
bar(dir1,t_ave(:,1:2)')
set(gca, 'XTickLabel',dir, 'XTick',1:numel(dir))
legend('0','-10','-15','-20','-25')
xlabel('Direction');
ylabel('Average time to regain stability (ms)')
axis([0 3 0 3000])

dir={'down'; 'up'};
dir1=[1 2];
subplot(1,2,2)
bar(dir1,t_ave(:,3:4)')
set(gca, 'XTickLabel',dir, 'XTick',1:numel(dir))
%legend('0','-10','-20','-30','-40')
legend('0','-20','-30','-40','-50')
xlabel('Direction');
ylabel('Average time to regain stability (ms)')
axis([0 3 0 3000])

% dir={'right'; 'left'; 'down'; 'up'};
% dir1=[1 2 3 4];
% figure
% bar(dir1,max_time1(:,1:4)')
% set(gca, 'XTickLabel',dir, 'XTick',1:numel(dir))
% legend('0','-10','-20','-25','-30')
% xlabel('Direction');
% ylabel('Max time to regain stability (ms)')
% 
% 
% dir={'right'; 'left'; 'down'; 'up'};
% dir1=[1 2 3 4];
% figure
% bar(dir1,t_ave(:,1:4)')
% set(gca, 'XTickLabel',dir, 'XTick',1:numel(dir))
% legend('0','-10','-20','-25','-30')
% xlabel('Direction');
% ylabel('Average time to regain stability (ms)')
load('Average_rate_total.mat');
rate_total(:,:,N_sub)=rate1;
save Average_rate_total.mat rate_total

load('Average_time_total.mat');
tave_total(:,:,N_sub)=t_ave;
save Average_time_total.mat tave_total

                    
                            
            
            
       