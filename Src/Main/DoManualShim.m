
function DoManualShim

global VCtl
global VObj
global VMag

if ~isfield(VCtl,'Sh_X2_Y2')
    warndlg('Please load Shim tab. Manual Shimming was not performed!');
    return;
end

Mxdims=size(VObj.Rho);
[xgrid,ygrid,zgrid]=meshgrid((-(Mxdims(2)-1)/2)*VObj.XDimRes:VObj.XDimRes:((Mxdims(2)-1)/2)*VObj.XDimRes,...
                            (-(Mxdims(1)-1)/2)*VObj.YDimRes:VObj.YDimRes:((Mxdims(1)-1)/2)*VObj.YDimRes,...
                            (-(Mxdims(3)-1)/2)*VObj.ZDimRes:VObj.ZDimRes:((Mxdims(3)-1)/2)*VObj.ZDimRes);

B0ShimField = VCtl.Sh_X .* xgrid + ...
              VCtl.Sh_Y .* ygrid + ...
              VCtl.Sh_Z .* zgrid + ...
              VCtl.Sh_ZX.* zgrid .* xgrid + ...
              VCtl.Sh_ZY.* zgrid .* ygrid + ...
              VCtl.Sh_Z2.* zgrid .^ 2 + ...
              VCtl.Sh_XYZ.* xgrid .* ygrid .* zgrid+ ...
              VCtl.Sh_X2_Y2.* (xgrid .* ygrid) .^ 2;
          
VMag.dB0 = VMag.dB0 + B0ShimField;

end