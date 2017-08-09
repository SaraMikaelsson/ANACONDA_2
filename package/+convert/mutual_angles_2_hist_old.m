function [ angle_hist, angle_containers, hit1_nrs, hit2_nrs, event_filter] = mutual_angles_2_hist_old( exp, metadata, hit1_m2q, hit2_m2q, total_m2q)


% This function returns the mutual angles between mass-selected double coincidence couples
% renaming to convenient names:
detname     = fieldnames(metadata.plot);
detname_str = detname{:};
detnr       = str2num(detname_str(4:end));
e_raw       = exp.e.raw(:,detnr); 
all_m2q_l   = exp.h.(detname_str).m2q_l;
idx_C2_1    =  e_raw(exp.e.(detname_str).filt.LC2,1);
idx_C2_2    = idx_C2_1 + 1;

m2q_1       = all_m2q_l(idx_C2_1);
m2q_2       = all_m2q_l(idx_C2_2);
parent_m2q  = m2q_1 + m2q_2;

% fetching the momenta:
dp_C2_1    = exp.h.(detname_str).dp(idx_C2_1, :);
dp_C2_2    = exp.h.(detname_str).dp(idx_C2_2, :);

% Get the mutual angles:
theta  = convert.vector_angle(dp_C2_1, dp_C2_2);

theta_f         = []; norm_p_res = [];

% Now we filter out the labels we are interested in:
if ~isempty(hit1_m2q);
        f_hit1  = ismember(m2q_1, hit1_m2q);
else    f_hit1 = true(size(m2q_1));
end
if ~isempty(hit2_m2q);
        f_hit2  = ismember(m2q_2, hit2_m2q);
else    f_hit2 = true(size(m2q_1));
end
if ~isempty(total_m2q);
        f_total = ismember(parent_m2q, total_m2q);
else    f_total = true(size(m2q_1));
end

f =  all([f_hit1, f_hit2, f_total], 2); %& theta > pi/4;

hit1_nrs  = idx_C2_1(f); % filter q, hit numbers of hit 1
hit2_nrs  = idx_C2_2(f); % filter q, hit numbers of hit 1

theta_f_i      = theta(f);

% adding the mutual angles found to the existing list:
theta_f        = [theta_f; theta_f_i];


norm_p_res_i   = general.vector.norm_vectorarray(  exp.h.(detname_str).dp(hit1_nrs, :) + ...
                                            exp.h.(detname_str).dp(hit2_nrs, :), 2);
norm_p_res      = [norm_p_res; norm_p_res_i];

theta_range           = metadata.plot.det1.mutual_angle.x_range;
theta_binsize         = metadata.plot.det1.mutual_angle.binsize;

% Histogram the mutual angles:
[angle_hist, angle_containers] = hist.H_solid_angle_polar(theta_f, theta_binsize, theta_range);

if strcmpi(metadata.plot.det1.mutual_angle.y_range, 'Normalized')
    angle_hist = angle_hist./sum(angle_hist);
end
    
event_filter = exp.e.(detname_str).filt.LC2;
event_filter(event_filter) = f;
end

