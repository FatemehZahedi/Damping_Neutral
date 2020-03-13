clc
clear
close all

% %nf=12;
% lfilename = 'C:\Users\fzahedi1admin\OneDrive - Arizona State University\Projects\Damping Map\Experiments\Test\Neutral\Data\Subject100\KD_S100_B6.txt';
% data1=load(filename);
% 
% Mass = 12;
% data = data1;
% 
% alpha = [pi/2, -pi/2, -pi/2, pi/2, pi/2, -pi/2, 0];
% a = [0, 0, 0, 0, 0, 0, 0];
% d = [0.36, 0, 0.42, 0, 0.4, 0, 0.126];
% theta=[0 0 0 0 0 0 -0.958709];
% dh = [theta' d' a' alpha'];
% h=0.001;
% s=2000;
% 
% % BUILD ROBOT--------------------------------------------------------------
% for i = 1:length(dh(:,1))
%     L{i} = Link('d', dh(i,2), 'a', dh(i,3), 'alpha', dh(i,4));
% end
% rob = SerialLink([L{1} L{2} L{3} L{4} L{5} L{6} L{7}]);
% 
% qm= data(:,2:7)';
% 
% Force_measure = data(s+1:end,9:10)';
% 
% ind1= data(s+1:end,18); % damping values for x
% ind2= data(s+1:end,19); % damping values for z
% 
% ind_trig = data(s+1:end,22);
% 
% ind_ind = data(s+1:end,23); % trial number
% 
% ind_pert = data(s+1:end,24); % perturbation direction
% 
% ind_fail = data(s+1:end,25); % failure inside the exp
% 
% for i=1:length(qm)
%     theta=[qm(:,i)' -0.958709]; %This should be in both ways
%     [T,all] = rob.fkine(theta);
%     phi_euler = atan2(T(2, 3), T(1, 3));
%     theta_euler = atan2(sqrt(T(2, 3)^2 + T(1, 3)^2), T(3, 3));
%     psi_euler = atan2(T(3, 2), -T(3, 1));
%     xm1(:,i)=[T(1,4) T(2,4) T(3,4) phi_euler theta_euler psi_euler]';
%     %[Ja,x(:,i)]=Jacobian(alpha,a,d,theta);
% end
% %xm1=data(:,3:8)';
% xm=xm1(:,s+1:end);
% 
% d1 = designfilt('lowpassiir','FilterOrder',12,'HalfPowerFrequency',20,'DesignMethod','butter','Samplerate',1000);
% 
% for i=1:size(xm,1)
%     xm(i,:)=filtfilt(d1,xm(i,:));
% end
% 
% ind_tn = find(ind_trig == 0);
% 
% ind_failure = find(ind_fail == 1);
% 
% fail = ind_ind(ind_failure);
% 
% for i=1:length(fail)
%     if fail(i) <= 10
%         if rem(fail(i),5)==0
%             failure(i,:)=[rem(fail(i),5)+5 ind1(ind_failure(i)) ind_pert(ind_failure(i))];
%         else 
%             failure(i,:)=[rem(fail(i),5) ind1(ind_failure(i)) ind_pert(ind_failure(i))];
%         end
%     else
%         if rem(fail(i),5)==0
%             failure(i,:)=[rem(fail(i),5)+5 ind2(ind_failure(i)) ind_pert(ind_failure(i))];
%         else 
%             failure(i,:)=[rem(fail(i),5) ind2(ind_failure(i)) ind_pert(ind_failure(i))];
%         end
%     end
% end
% 
% 
% if length(fail)==0
%     failure = [];
% end
% 
% j=1;
% n=1;
% for i=1:length(ind_tn)
%     if i < length(ind_tn)
%         if ind_tn(i+1)-ind_tn(i) > 1
%             clear new
%             new=[xm(:,ind_tn(j)-1000:ind_tn(i)+3000); Force_measure(:,ind_tn(j)-1000:ind_tn(i)+3000); ind1(ind_tn(j)-1000:ind_tn(i)+3000)'; ind2(ind_tn(j)-1000:ind_tn(i)+3000)'; ind_ind(ind_tn(j)-1000:ind_tn(i)+3000)'; ind_pert(ind_tn(j)-1000:ind_tn(i)+3000)'];
%             content{n}=new;
%             n=n+1;
%             j = i+1;
%         end
%     end
%     if i==length(ind_tn)
%         clear new
%         new=[xm(:,ind_tn(j)-1000:ind_tn(i)+3000); Force_measure(:,ind_tn(j)-1000:ind_tn(i)+3000); ind1(ind_tn(j)-1000:ind_tn(i)+3000)'; ind2(ind_tn(j)-1000:ind_tn(i)+3000)'; ind_ind(ind_tn(j)-1000:ind_tn(i)+3000)'; ind_pert(ind_tn(j)-1000:ind_tn(i)+3000)'];
%         content{n}=new;
%     end
% end
% 
% for i=1:size(content,2)
%     clear m
%     m=content{i};
%     cel{m(end-1,1)}=content{i};
% end
% 
% for i=1:length(fai)
%     cel{fail(i)}=[];
% end
% 
% save Force_test_S100_6.mat cel
%%
k=15;
Mass = [15 10 8 12 7 7.5];
figure
for i=2:6
    clear x_measure velocity_measure acc_measure F_estimated cel
    str1 = ['C:\Users\fzahedi1admin\OneDrive - Arizona State University\Projects\Damping Map\Experiments\Test\Neutral\Data\Subject100\Force_test_S100_',num2str(i),'.mat'];
    load(str1);
    m = cel{k};

    x_measure = m(1,size(m,2)-3000-1:end);
    velocity_measure = diff(x_measure)/0.001;
    acc_measure = diff(velocity_measure)/0.001;
    
    F_estimated = Mass(i)*acc_measure;
    
    if k<=10
        F_measured = m(7,size(m,2)-3000+1:end);
    else 
        F_measured = m(8,size(m,2)-3000+1:end);
    end
    
    subplot(2,1,1)
    hold on
    plot(F_estimated);
    ylabel('I*acc');
    legend('I=10','I=8','I=12','I=7','I=7.5')
    subplot(2,1,2)
    hold on 
    plot(F_measured);
    ylabel('F_{measured}');
    xlabel('Time (ms)');
    
end



%%
k = 16;

if k <=10 
    clear m x_measure velocity_measure acc_measure F_estimated
    m = cel{k};

    x_measure = m(1,size(m,2)-3000-1:end);
    velocity_measure = diff(x_measure)/0.001;
    acc_measure = diff(velocity_measure)/0.001;

    F_estimated = Mass*acc_measure + m(end-3,end)*velocity_measure(1:end-1);
    figure
    plot(F_estimated);
    hold on
    plot(m(7,size(m,2)-3000+1:end));
    str = ['AP direction with damping value of ',num2str(m(end-3,end))];
    title(str)
else
    clear m x_measure velocity_measure acc_measure F_estimated
    m = cel{k};

    x_measure = m(3,size(m,2)-3000-1:end);
    velocity_measure = diff(x_measure)/0.001;
    acc_measure = diff(velocity_measure)/0.001;

    F_estimated = Mass*acc_measure + m(end-2,end)*velocity_measure(1:end-1);
    figure
    plot(F_estimated);
    hold on
    F_measured = m(8,size(m,2)-3000+1:end);
    plot(m(8,size(m,2)-3000+1:end));
    str = ['AP direction with damping value of ',num2str(m(end-2,end))];
    title(str)
end
legend('Force_{estimated}','Force_{measured}');
xlabel('Time (ms)')
ylabel('Force N/m');
%%
for i=0:3
    figure
    for j=1:5
        k=5*i+j;
        subplot(5,1,j);
        if k <=10 
            clear m x_measure velocity_measure acc_measure F_estimated
            m = cel{k};

            x_measure = m(1,size(m,2)-3000-1:end);
            velocity_measure = diff(x_measure)/0.001;
            acc_measure = diff(velocity_measure)/0.001;

            F_estimated = Mass*acc_measure + m(end-3,end)*velocity_measure(1:end-1);
            plot(F_estimated);
            hold on
            plot(m(7,size(m,2)-3000+1:end));
            str = ['ML direction with damping value of ',num2str(m(end-3,end))];
            title(str)
        else
            clear m x_measure velocity_measure acc_measure F_estimated
            m = cel{k};

            x_measure = m(3,size(m,2)-3000-1:end);
            velocity_measure = diff(x_measure)/0.001;
            acc_measure = diff(velocity_measure)/0.001;

            F_estimated = Mass*acc_measure + m(end-2,end)*velocity_measure(1:end-1);
            plot(F_estimated);
            hold on
            F_measured = m(8,size(m,2)-3000+1:end);
            plot(m(8,size(m,2)-3000+1:end));
            str = ['AP direction with damping value of ',num2str(m(end-2,end))];
            title(str)
        end
        if j==3
           ylabel('Force N/m');
        end
        if j == 1
            legend('Force_{estimated}','Force_{measured}');
        end
    end
    xlabel('Time (ms)');
end
%%

radius_e = 0.005;

for j=1:size(cel,2)

      if size(cel{j},1)~= 0  
          clear m
          m=cel{j};

          M1(:,:,j) = m;

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
            M(1,:)=M1(1,:,5*i+j);
        else
            M(1,:)=M1(3,:,5*i+j);
        end
        
        %M(~any(M,2),:)=[];
        
        %for k=1:size(M,1)
            
            clear E ind_t
            E = M(1,size(M,2)-3000+1:end)-desired;
            ind_t = find(abs(E) <= radius_e);
            
            q = 1;
            flag = 0;
            for f=1:length(ind_t)
                
                if f < length(ind_t) && flag == 0
                    
                    if ind_t(f+1)-ind_t(f) > 1
                        
                        e_length = f - q;
                        
                        if e_length >= 500
                            
                            t_re1(j,i+1) = ind_t(q);
                            t_re2(j,i+1) = ind_t(q);
                            success1(j,i+1) = 1;
                            flag = 1;
                        else
                            q = f+1;
                        end
                    end
                end
                
                if f == length(ind_t) && flag == 0
                    
                    e_length = f - q;
                    
                    if e_length >= 500
                        
                        t_re1(j,i+1) = ind_t(q);
                        t_re2(j,i+1) = ind_t(q);
                        success1(j,i+1) = 1;
                    
                    else
                       
                       t_re1(j,i+1)=0;
                       t_re2(j,i+1)=3000;
                       success1(j,i+1) = -1; 
                    end
                end
            end
    end
end

dir={'right'; 'left'};
dir1=[1 2];
figure
subplot(1,2,1)
bar(dir1,t_re2(:,1:2)')
set(gca, 'XTickLabel',dir, 'XTick',1:numel(dir))
legend('0','-10','-15','-20','-25')
xlabel('Direction');
ylabel('Average time to regain stability (ms)')
axis([0 3 0 3000])

dir={'down'; 'up'};
dir1=[1 2];
subplot(1,2,2)
bar(dir1,t_re2(:,3:4)')
set(gca, 'XTickLabel',dir, 'XTick',1:numel(dir))
%legend('0','-10','-20','-30','-40')
legend('0','-20','-30','-40','-50')
xlabel('Direction');
ylabel('Average time to regain stability (ms)')
axis([0 3 0 3000])

        
    