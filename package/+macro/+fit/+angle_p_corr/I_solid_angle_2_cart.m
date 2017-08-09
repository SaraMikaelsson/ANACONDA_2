function [ pdf_cart, Integral ] = I_solid_angle_2_cart(theta, pdf_solid_angle)
% This function translates an intensity in solid angle units (weighted by
% the 1/sin(theta) weight factor) to the intensity in cartesian units. This
% increases the intensities at 90 degrees (1/sin(theta) is small), and decreases it around 180
% degrees (1/sin(theta) is large)

pdf_cart = pdf_solid_angle.*sin(theta);

if nargout > 1
Integral = trapz(theta, pdf_cart);
end

end

