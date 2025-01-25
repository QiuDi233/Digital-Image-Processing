function resized_image = my_imresize(image, scale, method)
    if nargin < 3
        method = 'bilinear'; % 没有第三个参数的话 就默认使用双线性插值
    end
    
    if strcmp(method, 'nearest')
        resized_image = nearest_interpolation(image, scale);
    end
    if strcmp(method, 'bilinear')
        resized_image = bilinear_interpolation(image, scale);
    end
end

function resized_image = nearest_interpolation(image, scale)
    if numel(scale) == 1
        new_height = round(size(image, 1) * scale);
        new_width = round(size(image, 2) * scale);
        scale_x = scale;
        scale_y = scale;
    else
        new_height = scale(1);
        new_width = scale(2);
        scale_x = new_height/size(image, 1);
        scale_y = new_width/size(image, 2);
    end
    resized_image = zeros(new_height, new_width, size(image, 3), class(image));
    for i = 1:new_height
        for j = 1:new_width
            src_i = min(round(i/scale_x), size(image, 1));
            src_j = min(round(j/scale_y), size(image, 2));
            resized_image(i, j, :) = image(src_i, src_j, :);
        end
    end 
end

function resized_image = bilinear_interpolation(image, scale)
   if numel(scale) == 1
        new_height = round(size(image, 1) * scale);
        new_width = round(size(image, 2) * scale);
        scale_x = scale;
        scale_y = scale;
   else
        new_height = scale(1);
        new_width = scale(2);
        scale_y = new_height/size(image, 1);
        scale_x = new_width/size(image, 2);
    end
    resized_image = zeros(new_height, new_width, size(image, 3), class(image));
    for i = 1:new_height
        for j = 1:new_width
            x = j/scale_x;
            y = i/scale_y;
            x1 = floor(x);
            y1 = floor(y);
            x2 = min(x1+1, size(image, 2)-1);
            y2 = min(y1+1, size(image, 1)-1);
            Q11 = image(y1, x1, :);
            Q21 = image(y1, x2, :);
            Q12 = image(y2, x1, :);
            Q22 = image(y2, x2, :);
            if x2 == x1
                R1 = Q11;
                R2 = Q12;
            else
                R1 = Q11 * (x2 - x)/(x2 - x1) + Q21 * (x - x1)/(x2 - x1);
                R2 = Q12 * (x2 - x)/(x2 - x1) + Q22 * (x - x1)/(x2 - x1);
            end
            if y2 == y1
                P = R1;
            else
                P = R1 * (y2 - y)/(y2 - y1) + R2 * (y - y1)/(y2 - y1);
            end
            resized_image(i, j, :) = P;
        end
    end 
end
