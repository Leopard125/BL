function model=CreateModel(start_location, end_location, radars)

    % 读取高程图
    H1 = imread('n38_w112_1arc_v3.tif');  % Get the elevation data
    H1 = H1(1:3600,1:3600);
    H1 = flip(H1,2);  % 翻转第二维度，方便显示
    H1_ele = zeros(300,300);  % 地图大小为300*300
    for i = 1:300
        for j = 1:300
            temp_ele = H1(((i-1)*12+1):i*12,((j-1)*12+1):j*12);
            H1_ele(i,j) = mean(temp_ele,'all');
        end
    end
    % 卷积平滑
    % n29_e107_1arc_v3.tif
    K = (1/45)*ones(6);

    % n39_w116_1arc_v3.tif
    % K = (1/30)*ones(7);

    % n29_e098_1arc_v1
    % K = (1/60)*ones(5);

    H1_smooth = conv2(H1_ele,K,'same');
    MAPSIZE_X = 300;  % x index: columns of H
    MAPSIZE_Y = 300;  % y index: rows of H 
    [X,Y] = meshgrid(1:MAPSIZE_X,1:MAPSIZE_Y);

    % 地图限制
    xmin = 1;
    xmax=MAPSIZE_X;
    
    ymin= 1;
    ymax= MAPSIZE_Y;
    
    % 这里只能放相对的高度
    zmin = 5;
    zmax = 20;  

    % 路径点个数（维数）
    n=6;
    
    % UAV的数目
    num=1;
    
    % 将参数内置到model中
    model.start=start_location;
    model.end=end_location;
    model.n=n;
    model.cons = 7;
    model.num=num;
    model.xmin=xmin;
    model.xmax=xmax;
    model.zmin=zmin;
    model.ymin=ymin;
    model.ymax=ymax;
    model.zmax=zmax;
    model.MAPSIZE_X = MAPSIZE_X;
    model.MAPSIZE_Y = MAPSIZE_Y;
    model.X = X;
    model.Y = Y;
    model.H = H1_smooth / 50;
    model.radars = radars;
    % PlotModel(model,pic);
end