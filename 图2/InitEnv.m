function [TargetList, UAVList, TC, TarLoc, radars] = InitEnv()
%INITENV initialize basic environment
%   此处显示详细说明
    % TargetList: RecTaskNum, AttTaskNum, RecExecTime*3, AttExecTime*3,
    % RecTimeWindow*2, AttTimeWindow*2 (0 for no TW), TargetValue(0~1)

%     TargetList = [1 1 8 11 13 10 12 15 0 0 0 0 9;
%                   1 1 10 13 14 17 20 24 0 0 185 215 8;
%                   0 1 0 0 0 17 18 21 0 0 0 0 8;
%                   1 1 9 12 14 15 17 20 0 0 200 230 9;
%                   1 0 19 21 23 0 0 0 0 0 0 0 7;
%                   1 1 9 12 14 15 17 21 0 0 0 0 6;
%                   0 1 0 0 0 17 18 21 0 0 0 0 4;
%                   1 1 9 12 14 15 17 20 0 0 160 200 8;
%                   1 1 8 11 13 10 12 15 0 0 0 0 5;
%                   1 1 10 13 14 17 20 24 0 0 185 215 4;
%                   0 1 0 0 0 17 18 21 0 0 0 0 8;
%                   1 1 9 12 14 15 17 20 0 0 200 230 3;
%                   1 0 19 21 23 0 0 0 0 0 0 0 6;
%                   1 1 9 12 14 15 17 21 0 0 0 0 4;
%                   0 1 0 0 0 17 18 21 0 0 0 0 9;
%                   1 1 9 12 14 15 17 20 0 0 160 200 10;
%                   1 1 8 11 13 10 12 15 0 0 0 0 10;
%                   1 1 10 13 14 17 20 24 0 0 185 215 10;
%                   0 1 0 0 0 17 18 21 0 0 0 0 5;
%                   1 1 9 12 14 15 17 20 0 0 200 230 3;];

    % UAVList: isRecUAV, isAttUAV, baseNo, velocity*3 (fuzzy), hit
    % probability, UAVval(0~10), munition
    % num of bases = 2
%     UAVList = [1 0 1 120 122 125 0 5;
%                0 1 1 84 86 87 0.95 4;
%                1 1 2 110 112 115 0.7 9;
%                0 1 2 96 97 100 0.93 3;
%                1 0 1 120 122 125 0 5;
%                0 1 1 84 86 87 0.95 4;
%                1 1 2 115 117 118 0.65 10;
%                1 1 2 110 112 115 0.7 9;
%                0 1 2 96 97 100 0.93 3;];
    TargetList = load("TargetList.mat").TargetList;
    UAVList = load("UAVList.mat").UAVList;
    TarLoc = load("TarLoc.mat").TarLoc;
    TarLoc = TarLoc(:, 1:2);

    % Threats of n39_w116_1arc_v3.tif
    R1 = 25; h1 = 25;
    x1 =67; y1 = 220;
    
    R4 = 25; h4 = 25;
    x4 =127; y4 =61;
    
    R5 =25; h5 = 25;
    x5 =101; y5 = 134;

    R6 = 25; h6 = 25;
    x6 = 225; y6 = 172;

%     R7 = 15; h7 = 25;
%     x7 = 179; y7 = 239;

%     R8 = 15; h8 = 25;
%     x8 = 192; y8 = 138;

    R9 = 25; h9 = 25;
    x9 = 259; y9 = 92;

%     R10 = 15; h10 = 25;
%     x10 = 193; y10 = 82;
% 
%     R11 = 15; h11 = 25;
%     x11 = 75; y11 = 261;

%     R12 = 15; h12 = 25;
%     x12 = 34; y12 = 182;

%     R13 = 15; h13 = 25;
%     x13 = 188; y13 = 45;
    radars = [x4 y4 R4 h4;x1 y1 R1 h1;x5 y5 R5 h5;x6 y6 R6 h6;x9 y9 R9 h9];

%     % Threats of n29_e107_1arc_v3.tif
%     R2 = 20; h2 = 40;
%     x2 =124; y2 = 63;
%     
%     R7 = 30; h7 = 40;
%     x7 =149; y7 = 191;
%     
%     R8 = 15; h8 = 42;
%     x8 =220; y8 = 160;
%     
%     
%     R5 = 15; h5 = 30;
%     x5 =261; y5 = 173;
%     
%     
%     R13 = 15; h13 = 42;
%     x13 =236; y13 = 125;
%     
%     R10 = 15; h10 = 42;
%     x10 =162; y10 = 128;
%     
%     
%     R11 = 20; h11 = 42;
%     x11 =219; y11 = 67;
%     
%     R12 = 35; h12 = 48;
%     x12 =75; y12 = 203;
%     radars = [x10 y10 R10 h10;x11 y11 R11 h11;x12 y12 R12 h12;x13 y13 R13 h13;x2 y2 R2 h2;x5 y5 R5 h5;x7 y7 R7 h7;x8 y8 R8 h8];

    % TC: distance between targets & bases (MAP), from [rows] to [cols]
    % format: base1; base2; target1; target2; ...; targetx; ...
    n = size(TargetList, 1);
%     xm = 250;
%     ym = 250;
%     TarLoc = zeros(n+2, 2);
%     TarLoc(1, :) = [30, 50];
%     TarLoc(2, :) = [250, 250];
%     for i = 3:n+2
%         x = rand(1) * xm + 20;
%         y = rand(1) * ym + 20;
%         TarLoc(i, 1) = x;
%         TarLoc(i, 2) = y;
%     end
%     TarLoc = [40, 40;
%               250, 260;
%               152, 50;
%               271, 30;
%               137, 220;
%               98, 75;
%               117, 161;
%               201, 172;
%               27, 144;
%               80, 245];

%     TarLoc = [40, 40;
%               250, 260;
%               152, 50;
%               271, 30;
%               137, 220;
%               98, 75;
%               117, 161;
%               201, 172;
%               27, 144;
%               80, 245;
%               157, 89;
%               231, 112;
%               200, 201;
%               21, 200;
%               59, 76;
%               177, 122;
%               191, 101;
%               273, 244;
%               78, 123;
%               134, 145;
%               90, 89;
%               148, 179;
%               195, 23;];

    TarLocReal = 100*TarLoc;
    TC = squareform(pdist(TarLocReal));

%     TarVal = TargetList(:, 13);
%     TarVal = (TarVal - min(TarVal)) / (max(TarVal) - min(TarVal)) * 0.999 + 0.0005;
%     TarThreat = load("TarThreat.mat").TarThreat;
% %     TarThreat = rand(size(TargetList, 1), 1);
%     TarDist = zeros(size(TarVal));
%     for i = 1:n
%         TarDist(i) = min([norm(TarLoc(1, :) - TarLoc(i+2, :)), norm(TarLoc(2, :) - TarLoc(i+2, :))]);
%     end
%     TarDist = (TarDist - min(TarDist)) / (max(TarDist) - min(TarDist)) * 0.999 + 0.0005;
%     TarFeature = [TarVal, TarThreat, TarDist];    % [Value, Threat, Dist] 
% 
%     %% ================== ANFIS training & Inference ================== %%
%     load('anfisModel.mat','trnFIS');
%     y_pred = evalfis(trnFIS, TarFeature);
%     y_class = round(y_pred);
%     y_class = max(1,min(3,y_class));
%     for i = 1:n
%         if y_class(i) == 1
%             TargetList(i, 1:2) = [1, 0];
%         elseif y_class(i) == 2
%             TargetList(i, 1:2) = [0, 1];
%         else
%             TargetList(i, 1:2) = [1, 1];
%         end
%     end

%     % Draw
%     TarLocZ = 15;
%     model = CreateModel(0, 0, radars);
%     res_fig = figure;
%     PlotModel(model, res_fig);
%     hold on
%     TarLocZList = zeros(size(TarLoc, 1), 1);
%     for i = 1:size(TarLoc, 1)
%         TarLocZList(i) = TarLocZ + model.H(floor(TarLoc(i, 2)), floor(TarLoc(i, 1)));
%     end
%     TarLoc = [TarLoc TarLocZList];
% 
%     % Depot points
%     scatter3(TarLoc(1:2, 1), TarLoc(1:2, 2), TarLoc(1:2, 3), 200, 'yellow', 'd', 'filled');
%     % Task points (static tasks)
%     scatter3(TarLoc(3:end, 1), TarLoc(3:end, 2), TarLoc(3:end, 3), 200, 'red', 's', 'filled');
%     a=1
end

