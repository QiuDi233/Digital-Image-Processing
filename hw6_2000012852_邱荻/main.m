function output_image = generate_vignette(input_image)
    %得到图像高和宽 以及中心的位置
    [height, width, ~] = size(input_image);
    center = [width/2, height/2];
    
    %计算图像中心到四个角的距离
    max_distance = norm(center);
    
    %生成一个网格 每个点表示该点到图像中心的距离
    [x, y] = meshgrid(1:width, 1:height);
    distances = sqrt((x - center(1)).^2 + (y - center(2)).^2);
    
    %根据距离计算每个点的亮度调整系数 距离越远越黑
    vignette = 1 - (distances / max_distance);
    vignette = max(0, min(vignette, 1));

    %将uint8类型的图像转换为double类型 归一化到[0,1]（不然报错）
    input_image = double(input_image) / 255.0; 
    
    
    %调整图像 离中心越远越黑
    output_image = bsxfun(@times, input_image, vignette);
end

input_image = imread('cat.png');

output_image = generate_vignette(input_image);

imwrite(output_image, 'cat_vignette.png');
