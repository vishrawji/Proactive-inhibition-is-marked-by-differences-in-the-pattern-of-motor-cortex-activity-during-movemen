%Script to reporduce the figures in the manuscript: Proactive inhibition is marked by differences in the pattern of motor cortex activity during movement preparation and execution

cd('/Users/Vish 1/Documents/Characterising the nature of proactive and reactive inhibitio - a TMS study/Simple Stop Signal Task/Result')

load('cue_response_data.mat')

cue_labels = {'Cue','50','100','150','200','250','300'};

fig = figure
ylabel('\bf Normalised to baseline MEP amplitude')
subplot(2,2,1)
errorbar(mean(pa_go_cue(:,2:end)),std(pa_go_cue(:,2:end))/sqrt(length(pa_go_cue)),'LineWidth',2)
hold on
errorbar(mean(pa_stop_cue(:,2:end)),std(pa_stop_cue(:,2:end))/sqrt(length(pa_stop_cue)),'LineWidth',2)
y = 1;
line([0,8],[y,y],'LineStyle','--','LineWidth',2,'Color','k')
set(gca,'FontWeight','bold')
set(gca,'linewidth',2)
xticks([1 2 3 4 5 6 7 8])
xticklabels(cue_labels)
xlim([0,8])
ylim([0,4.5])
xlabel('\bf Time from cue (ms)')
legend('Go-only','SST','Location','northwest')
title('PA', 'FontSize', 15);
box off

subplot(2,2,2)
errorbar(mean(ap_go_cue(:,2:end)),std(ap_go_cue(:,2:end))/sqrt(length(ap_go_cue)),'LineWidth',2)
hold on
errorbar(mean(ap_stop_cue(:,2:end)),std(ap_stop_cue(:,2:end))/sqrt(length(ap_stop_cue)),'LineWidth',2)
set(gca,'FontWeight','bold')
set(gca,'linewidth',2)
xticks([1 2 3 4 5 6 7 8])
xticklabels(cue_labels)
xlim([0,8])
ylim([0,4.5])
xlabel('\bf Time from cue (ms)')
title('AP', 'FontSize', 15);
line([0,8],[y,y],'LineStyle','--','LineWidth',2,'Color','k')
box off

response_labels = {'50-100','100-150','150-200','200-250','250-300','300-350'};

pa_go_response(pa_go_response == 0) = NaN;
pa_stop_response(pa_stop_response == 0) = NaN;
ap_go_response(ap_go_response == 0) = NaN;
ap_stop_response(ap_stop_response == 0) = NaN;


subplot(2,2,3)
errorbar(nanmean(pa_go_response),nanstd(pa_go_response)/sqrt(length(pa_go_response)),'LineWidth',2)
hold on
errorbar(nanmean(pa_stop_response),nanstd(pa_stop_response)/sqrt(length(pa_stop_response)),'LineWidth',2)
set(gca,'FontWeight','bold')
set(gca,'linewidth',2)
xticklabels(response_labels)
xlim([0,7])
ylim([0,7])
xlabel('\bf Time from response (ms)')
set(gca,'Xdir','reverse')
box off
line([0,8],[y,y],'LineStyle','--','LineWidth',2,'Color','k')

subplot(2,2,4)
errorbar(nanmean(ap_go_response),nanstd(ap_go_response)/sqrt(length(ap_go_response)),'LineWidth',2)
hold on
errorbar(nanmean(ap_stop_response),nanstd(ap_stop_response)/sqrt(length(ap_stop_response)),'LineWidth',2)
set(gca,'FontWeight','bold')
set(gca,'linewidth',2)
xticklabels(response_labels)
xlim([0,7])
ylim([0,7])
xlabel('\bf Time from response (ms)')
set(gca,'Xdir','reverse')
box off
line([0,8],[y,y],'LineStyle','--','LineWidth',2,'Color','k')
hold off

% Give common xlabel, ylabel and title to your figure
han=axes(fig,'visible','off'); 
han.YLabel.Visible='on';
ylabel(han,'\bf Normalised to baseline MEP amplitude', 'FontSize', 16);
%% CRT
crt_labels = {'Baseline','WS+250','IS','35% RT','70% RT'};

fig = figure
subplot(1,3,[1:2])
errorbar(mean(pa_crt),std(pa_crt)/sqrt(length(pa_crt)),'LineWidth',2)
hold on
errorbar(mean(ap_crt),std(ap_crt)/sqrt(length(ap_crt)),'LineWidth',2,'LineStyle','--')
set(gca,'FontWeight','bold')
set(gca,'linewidth',2)
xticks([1 2 3 4 5])
xticklabels(crt_labels)
xlim([0,6])
ylim([0,3])
ylabel('\bf Normalised to baseline MEP amplitude')
xlabel('\bf Time from cue (ms)')
legend('PA','AP','Location','northwest')
box off

subplot(1,3,3)
plot(latency','LineWidth',2,'Color','k')
set(gca,'FontWeight','bold')
set(gca,'linewidth',2)
xticks([1 2])
xticklabels({'PA','AP'})
xlim([0.5,2.5])
ylim([17,27])
ylabel('MEP latency (ms)')
xlabel('Coil orientation')
box off
%% Individual LDS plots
load('cue_response_data.mat')

figure 

x = [0:1:6];
y = [0:1:6];

for i = 1:13
    a  = (pa_go_cue(i,[2:end]));
    b = (ap_go_cue(i,[2:end]));
    c = (pa_stop_cue(i,[2:end]));
    d = (ap_stop_cue(i,[2:end]));
    
    subplot(3,5,i)
    plot((pa_go_cue(i,[2:end])),(ap_go_cue(i,[2:end])),'b-o','LineWidth',2)
    hold on
    plot((pa_stop_cue(i,[2:end])),(ap_stop_cue(i,[2:end])),'-.ro','LineWidth',2)
    set(gca,'FontWeight','bold')
    set(gca,'linewidth',2)
    ylim([0 ceil(max([ap_stop_cue(i,:),ap_go_cue(i,:)]))])
    xlim([0 ceil(max([pa_stop_cue(i,:),pa_go_cue(i,:)]))])
    plot(x,y,'--k','LineWidth',2)
    title('Cue-locked', 'FontSize', 15);
    %ylabel('\bf Normalised to baseline AP MEP amplitude','FontSize',14)
    %xlabel('\bf Normalised to baseline PA MEP amplitude','FontSize',14)
    plot(a(1),b(1),'b*', 'MarkerSize', 14)
    plot(c(1),d(1),'r*', 'MarkerSize', 14)
    %legend('Go-only','SST','Location','northwest')
    box off
end

for i = 1:13
    a  = (pa_go_response(i,1));
    b = (ap_go_response(i,1));
    c = (pa_stop_response(i,1));
    d = (ap_stop_response(i,1));
    
    subplot(3,5,i)
    plot((pa_go_response(i,:)),(ap_go_response(i,:)),'b-o','LineWidth',2)
    hold on
    plot((pa_stop_response(i,:)),(ap_stop_response(i,:)),'-.ro','LineWidth',2)
    set(gca,'FontWeight','bold')
    set(gca,'linewidth',2)
    ylim([0 ceil(max([ap_stop_response(i,:),ap_go_response(i,:)]))])
    xlim([0 ceil(max([pa_stop_response(i,:),pa_go_response(i,:)]))])
    plot(x,y,'--k','LineWidth',2)
    title('Response-locked', 'FontSize', 15);
    %ylabel('\bf Normalised to baseline AP MEP amplitude','FontSize',14)
    %xlabel('\bf Normalised to baseline PA MEP amplitude','FontSize',14)
    plot(a(1),b(1),'b*', 'MarkerSize', 14)
    plot(c(1),d(1),'r*', 'MarkerSize', 14)
    %legend('Go-only','SST','Location','northwest')
    box off
end
%%
load('cue_response_data.mat')

% Individual Distance measures 

    a  = (pa_go_cue(:,[2:end]));
    b = (ap_go_cue(:,[2:end]));
    c = (pa_stop_cue(:,[2:end]));
    d = (ap_stop_cue(:,[2:end]));
    
    e  = pa_go_response;
    f = ap_go_response;
    g = pa_stop_response;
    h = ap_stop_response;

% Euclidian 
for i = 1:size(a,1)
    for j = 1:size(a,2)
    cue_euc_dist(i,j) = pdist2([a(i,j),b(i,j)],[c(i,j),d(i,j)],'euclidean');
    end
end

for i = 1:size(e,1)
    for j = 1:size(e,2)
    response_euc_dist(i,j) = pdist2([e(i,j),f(i,j)],[g(i,j),h(i,j)],'euclidean');
    end
end

% Cosine
for i = 1:size(a,1)
    for j = 1:size(a,2)
    cue_go = [a(i,j) b(i,j)];
    cue_stop = [c(i,j) d(i,j)];
    cue_v2 = [1 1];
    cue_cos_dist_go(i,j) = 1 - dot(cue_go,cue_v2)/norm(cue_go)/norm(cue_v2);
    cue_cos_dist_stop(i,j) = 1 - dot(cue_stop,cue_v2)/norm(cue_stop)/norm(cue_v2);
    cue_cos_dist_between(i,j) = pdist2(cue_go, cue_stop, 'cosine');
    end
end

for k = 1:size(e,1)
    for l = 1:size(e,2)
    response_go = [e(k,l) f(k,l)];
    response_stop = [g(k,l) h(k,l)];
    response_v2 = [1 1];
    response_cos_dist_go(k,l) = pdist2(response_go, response_v2, 'cosine');
    response_cos_dist_stop(k,l) = pdist2(response_stop, response_v2, 'cosine');
    response_cos_dist_between(k,l) = pdist2(response_go, response_stop, 'cosine');
    end
end


%% Simulated distance measures
% cue-locked

load('cue_response_data.mat')

sim_pa_go_cue = bootstrp(100,@mean,pa_go_cue);
sim_ap_go_cue = bootstrp(100,@mean,ap_go_cue);

sim_pa_go_cue = sim_pa_go_cue(:,[2:end]);
sim_ap_go_cue = sim_ap_go_cue(:,[2:end]);

mean_pa_go_cue  = mean(pa_go_cue(:,[2:end]));
mean_ap_go_cue = mean(ap_go_cue(:,[2:end]));

for i = 1:length(mean_pa_go_cue)
    for j = 1:length(sim_pa_go_cue)
            sim_cue_euc_dist(j,i) = pdist2([mean_pa_go_cue(i),mean_ap_go_cue(i)],[sim_pa_go_cue(j,i),sim_ap_go_cue(j,i)],'euclidean');
            sim_cue_cos_dist(j,i) = pdist2([mean_pa_go_cue(i),mean_ap_go_cue(i)],[sim_pa_go_cue(j,i),sim_ap_go_cue(j,i)],'cosine');
    end
end

% response-locked
sim_pa_go_response = bootstrp(100,@nanmean,pa_go_response);
sim_ap_go_response = bootstrp(100,@nanmean,ap_go_response);

mean_pa_go_response  = nanmean(pa_go_response);
mean_ap_go_response = nanmean(ap_go_response);

for i = 1:length(mean_pa_go_response)
    for j = 1:length(sim_pa_go_response)
            sim_response_euc_dist(j,i) = pdist2([mean_pa_go_response(i),mean_ap_go_response(i)],[sim_pa_go_response(j,i),sim_ap_go_response(j,i)],'euclidean');
            sim_response_cos_dist(j,i) = pdist2([mean_pa_go_response(i),mean_ap_go_response(i)],[sim_pa_go_response(j,i),sim_ap_go_response(j,i)],'cosine');
    end
end

%% Plotting the distance measures

%% Plotting PA against AP (linear dynamical system view)
figure

x = [0:1:6];
y = [0:1:6];

a  = mean(pa_go_cue(:,[2:end]));
b = mean(ap_go_cue(:,[2:end]));
c = mean(pa_stop_cue(:,[2:end]));
d = mean(ap_stop_cue(:,[2:end]));

subplot(3,2,1)
plot(mean(pa_go_cue(:,[2:end])),mean(ap_go_cue(:,[2:end])),'b-o','LineWidth',2)
hold on
plot(mean(pa_stop_cue(:,[2:end])),mean(ap_stop_cue(:,[2:end])),'-.ro','LineWidth',2)
set(gca,'FontWeight','bold')
set(gca,'linewidth',2)
ylim([0 ceil(max([mean(ap_go_cue(:,[2:end])),mean(ap_stop_cue(:,[2:end]))]))])
xlim([0 ceil(max([mean(pa_go_cue(:,[2:end])),mean(pa_stop_cue(:,[2:end]))]))])
plot(x,y,'--k','LineWidth',2)
title('Cue-locked', 'FontSize', 20);
ylabel({'\bf Normalised to baseline'; 'AP MEP amplitude'},'FontSize',14)
xlabel({'\bf Normalised to baseline'; 'PA MEP amplitude'},'FontSize',14)
plot(a(1),b(1),'b*', 'MarkerSize', 14)
plot(c(1),d(1),'r*', 'MarkerSize', 14)
legend('Go-only','SST','Location','northwest')
xticks([0:1:4])
yticks([0:1:3])
box off


e = nanmean(pa_go_response);
f =  nanmean(ap_go_response);
g = nanmean(pa_stop_response);
h = nanmean(ap_stop_response);

subplot(3,2,2)
plot(nanmean(pa_go_response),nanmean(ap_go_response),'b-o','LineWidth',2)
hold on
plot(nanmean(pa_stop_response),nanmean(ap_stop_response),'-.ro','LineWidth',2)
set(gca,'FontWeight','bold')
set(gca,'linewidth',2)
ylim([0 ceil(max([nanmean(ap_go_response),nanmean(ap_stop_response)]))])
xlim([0 ceil(max([nanmean(pa_go_response),nanmean(pa_stop_response)]))])
plot(x,y,'--k','LineWidth',2)
title('Response-locked', 'FontSize', 20);
ylabel({'\bf Normalised to baseline'; 'AP MEP amplitude'},'FontSize',14)
xlabel({'\bf Normalised to baseline'; 'PA MEP amplitude'},'FontSize',14)
plot(e(1),f(1),'b*', 'MarkerSize', 14)
plot(g(1),h(1),'r*', 'MarkerSize', 14)
legend('Go-only','SST','Location','northwest')
xticks([0:1:6])
yticks([0:1:6])
box off

% Euclidean distance
cue_labels = {'Cue','50','100','150','200','250','300'};
response_labels = {'50-100','100-150','150-200','200-250','250-300','300-350'};
respose_labels2 = flip(response_labels);

subplot(3,2,3)
y = [nanmean(cue_euc_dist); nanmean(sim_cue_euc_dist)]';
b = bar(y);
b(1).FaceColor = [0 0 0];
b(2).FaceColor = [1 1 1];
ax = gca;
set(ax,'FontWeight','bold','linewidth',2)
xticklabels(cue_labels)
xlabel('\bf Time from cue (ms)')
ylabel('\bf Euclidian distance','FontSize',14) % right y-axis
box off
hold off

subplot(3,2,4)
y = [flip(nanmean(response_euc_dist)); flip(nanmean(sim_response_euc_dist))]';
b = bar(y);
b(1).FaceColor = [0 0 0];
b(2).FaceColor = [1 1 1];
ax = gca;
set(ax,'FontWeight','bold','linewidth',2)
xticklabels(respose_labels2)
xlabel('\bf Time from response (ms)')
ylabel('\bf Euclidian distance','FontSize',14) % right y-axis
box off
hold off

cue_labels = {'Cue','50','100','150','200','250','300'};
response_labels = {'50-100','100-150','150-200','200-250','250-300','300-350'};
respose_labels2 = flip(response_labels);

% Cosine distance

subplot(3,2,5)
y = [nanmean(cue_cos_dist_between); nanmean(sim_cue_cos_dist)]';
b = bar(y);
b(1).FaceColor = [0 0 0];
b(2).FaceColor = [1 1 1];
ax = gca;
set(ax,'FontWeight','bold','linewidth',2)
xticklabels(cue_labels)
xlabel('\bf Time from cue (ms)')
ylabel('\bf Cosine distance','FontSize',14) % right y-axis
ylim([0 0.15])
box off
hold off

subplot(3,2,6)
y = [flip(nanmean(response_cos_dist_between)); flip(nanmean(sim_response_cos_dist))]';
b = bar(y);
b(1).FaceColor = [0 0 0];
b(2).FaceColor = [1 1 1];
ax = gca;
set(ax,'FontWeight','bold','linewidth',2)
xticklabels(respose_labels2)
xlabel('\bf Time from response (ms)')
ylabel('\bf Cosine distance','FontSize',14) % right y-axis
box off
hold off
