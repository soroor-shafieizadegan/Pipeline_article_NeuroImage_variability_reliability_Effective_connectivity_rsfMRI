function Imagesc_group_PCA(SPM_dir,Work_dir)
%%%%%%%%%%%%%%%%%
%GROUP_LEVEL PEB
%%%%%%%%%%%%%%%%%
load([Work_dir '/Results_paper_variability/DCM/Basic/Smith/Full_model/PEB_group/PCA_group.mat'])
load([Work_dir '/DatasetKuehn/sub-01_summary/DCM/Basic/Smith/Full_model/GCM_DMN_full_estim.mat']);
DCM=GCM;

figure('units','normalized','outerposition',[0 0 1 1]);

A_matrix=full(vec2mat(coeff(1:16,1),4)');

h=imagesc(A_matrix);
set(h,'alphadata',~isnan(A_matrix))

colorbar;

axis square;
xlabel('\textbf{\underline{From}}','FontSize',40,'Fontweight','bold','Interpreter','latex'); ylabel('\textbf{\underline{To}}','FontSize',40,'Fontweight','bold','Interpreter','latex');
set(gca,'XAxisLocation','top','Tag','connectivity');

title_str = ['First principal component'];

title(title_str,'FontSize',46);


for region=1:length({DCM{1}.xY.name})
    regions(region)={DCM{1}.xY(region).name(5:end)};
end

if size(A_matrix,1) == size(A_matrix,2) && ...
        size(A_matrix,1) == length({DCM{1}.xY.name})
    set(gca,'YTickLabel',regions,...
        'YTick',1:length({DCM{1}.xY.name}),...
        'XTickLabel',regions,'fontweight','bold','fontsize',40,'XTick',...
        1:length({DCM{1}.xY.name}),'TickLabelInterpreter', 'none');
end

for side1=1:4
    for side2=1:4
        if ~isnan(A_matrix(side2,side1))
            text(side1,side2,num2str(round(A_matrix(side2,side1),2)),'HorizontalAlignment','center','Fontweight','bold','Fontsize',40);
            
        elseif isnan(A_matrix(side2,side1))
            text(side1,side2,'ns','HorizontalAlignment','center','Fontweight','bold','Fontsize',40);
        end
    end
end

%make sure that black values are seen on color background
cmap_custom=parula;
cmap_custom(1:4,:)=[];
colormap(cmap_custom);

set(gcf,'PaperPositionMode','auto');
saveas(gcf,[Work_dir '/Figures_paper_variability/Group_PCA.bmp']);
close;
clear DCM PEB;
end