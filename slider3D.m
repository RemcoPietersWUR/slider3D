function slider3D(CTvol)
%Slider #D volume GUI

%Image volume size
[px_x,px_y,px_z]=size(CTvol);


%Setup figure
scrsz = get(groot,'ScreenSize');
hFig = figure('Position',[20,50,scrsz(3)-40,scrsz(4)-150]);
hFig.Resize = 'off';
plotsz = hFig.InnerPosition;

subplot(1,3,1)
imshow(squeeze(CTvol(:,:,round(px_z/2,0))));
title('XY view')
XYaxis = gca;

subplot(1,3,2)
imshow(squeeze(CTvol(:,round(px_y/2,0),:)));
title('XZ view')
XZaxis = gca;

subplot(1,3,3)
imshow(squeeze(CTvol(round(px_x/2,0),:,:)));
title('YZ view')
YZaxis = gca;

%Slider control
%Z-slider
sliceZ=round(px_z/2,0);
uicontrol('Parent',hFig, 'Style','slider', 'Value',sliceZ, 'Min',1,...
    'Max',px_z, 'SliderStep', [0.01 0.10], ...
    'Position',[plotsz(1)+20 plotsz(4)/2-150 20 300], 'Callback',@sliderZ_callback)
%Text above Z-slider
hTxtZ = uicontrol('Style','text', 'Position',[plotsz(1)+20 plotsz(4)/2-190 20 20], 'String',['Z']);
%Y-slider
sliceY=round(px_y/2,0);
uicontrol('Parent',hFig, 'Style','slider', 'Value',sliceY, 'Min',1,...
    'Max',px_y, 'SliderStep', [0.01 0.10], ...
    'Position',[plotsz(1)+50 plotsz(4)/2-150 20 300], 'Callback',@sliderY_callback)
%Text above Y-slider
hTxtY = uicontrol('Style','text', 'Position',[plotsz(1)+50 plotsz(4)/2-190 20 20], 'String',['Y']);
%X-slider
sliceX=round(px_x/2,0);
uicontrol('Parent',hFig, 'Style','slider', 'Value',sliceX, 'Min',1,...
    'Max',px_x, 'SliderStep', [0.01 0.10], ...
    'Position',[plotsz(1)+80 plotsz(4)/2-150 20 300], 'Callback',@sliderX_callback)
%Text above X-slider
hTxtX = uicontrol('Style','text', 'Position',[plotsz(1)+80 plotsz(4)/2-190 20 20], 'String',['X']);

%Draw ellipse
XYellipse=imellipse(XYaxis,[px_y*0.05,px_x*0.05,px_y*0.9,px_x*0.9]);
XZellipse=imellipse(XZaxis,[px_z*0.05,px_x*0.05,px_z*0.9,px_x*0.9]);
YZellipse=imellipse(YZaxis,[px_z*0.05,px_y*0.05,px_z*0.9,px_y*0.9]);

% Callback functions
    function sliderZ_callback(hObj, eventdata)
        %Get slide number from slider position
        sliceZ = round(get(hObj,'Value'),0);
        posXY = getPosition(XYellipse);
        posXZ = getPosition(XZellipse);
        posYZ = getPosition(YZellipse);
        subplot(1,3,1)
        imshow(squeeze(CTvol(:,:,round(sliceZ,0))));
        title('XY view')
        hold off
        XYellipse=imellipse(XYaxis,posXY);
        subplot(1,3,2)
        imshow(squeeze(CTvol(:,round(sliceY,0),:)));
        title('XZ view')
        hold off
        XZellipse=imellipse(XZaxis,[posXZ(1),posXY(2),posXZ(3),posXY(4)]);
        subplot(1,3,3)
        imshow(squeeze(CTvol(round(sliceX,0),:,:)));
        title('YZ view')
        hold off
        YZellipse=imellipse(YZaxis,[posXZ(1),posXY(1),posXZ(3),posXY(3)]);
    end
    function sliderY_callback(hObj, eventdata)
        %Get slide number from slider position
        sliceY = round(get(hObj,'Value'),0);
        posXY = getPosition(XYellipse);
        posXZ = getPosition(XZellipse);
        posYZ = getPosition(YZellipse);
        subplot(1,3,2)
        imshow(squeeze(CTvol(:,round(sliceY,0),:)));
        title('XZ view')
        hold off
        XZellipse=imellipse(XZaxis,posXZ);
        subplot(1,3,1)
        imshow(squeeze(CTvol(:,:,round(sliceZ,0))));
        title('XZ view')
        hold off
        XYellipse=imellipse(XYaxis,[posXY(1),posXZ(2),posXY(3),posXZ(4)]);
        subplot(1,3,3)
        imshow(squeeze(CTvol(round(sliceX,0),:,:)));
        title('YZ view')
        hold off
        YZellipse=imellipse(YZaxis,[posYZ(1),posXY(1),posXZ(3),posXY(3)]);
    end
    function sliderX_callback(hObj, eventdata)
        %Get slide number from slider position
        sliceX = round(get(hObj,'Value'),0);
        posXY = getPosition(XYellipse);
        posXZ = getPosition(XZellipse);
        posYZ = getPosition(YZellipse);
        subplot(1,3,3)
        imshow(squeeze(CTvol(round(sliceX,0),:,:)));
        title('YZ view')
        hold off
        YZellipse=imellipse(YZaxis,posYZ);
        subplot(1,3,1)
        imshow(squeeze(CTvol(:,:,round(sliceZ,0))));
        title('XY view')
        hold off
        XYellipse=imellipse(XYaxis,[posYZ(2),posXY(2),posYZ(4),posXY(4)]);
        subplot(1,3,2)
        imshow(squeeze(CTvol(:,round(sliceY,0),:)));
        title('XZ view')
        hold off
        XZellipse=imellipse(XZaxis,[posXZ(1),posXY(2),posXZ(3),posXY(4)]);
    end
uiwait(hFig);
end