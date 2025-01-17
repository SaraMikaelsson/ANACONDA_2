function [xvalues, c] = get_counts_in_roi(path, histogram, Bincenters )
xvalues = {'C1H3','C2H3','C2H4','C2H5','C3H3','C3H5','C4H3','C4H5','C4H6','C4H7','C5H3','C5H5','C5H7','C6H4','C6H5','C6H7','C7H7','C8H11'};
yvalues =xvalues;
c = NaN(length(xvalues),length(xvalues));

%% load all rois in path
rois = dir(fullfile(path,'*.mat'));
for k = 1:numel(rois)
    histogram_roi =histogram';
    filename = dir(fullfile(path,rois(k).name));
    roi = load([path,filename.name],'roi'); % much better than EVAL and LOAD.s
%%
[tof1,tof2]= meshgrid(Bincenters,Bincenters);

filter = inROI(roi.roi,double(tof1),double(tof2));
histogram_roi(~filter) = NaN;

% figure
% surface(Bincenters, Bincenters, histogram_roi); shading interp

counts = sum(sum(histogram_roi,'omitnan' ));
name = upper(filename.name); name = split(name,'.');
name = split(name(1),'_');
ii = find(strcmp(name{1},xvalues)==1); jj = find(strcmp(name{2},yvalues)==1);
c(jj,ii) = counts;
end

end