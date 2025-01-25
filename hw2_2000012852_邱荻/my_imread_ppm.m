function image = my_imread_ppm(filename)
     fid = fopen(filename, 'r');
 
     line = fgetl(fid);
    
     parts = strsplit(line, ' ');
    
     % 提取宽度 高度 和最大像素值
     width = str2double(parts{2});
     height = str2double(parts{3});
     max_val = str2double(parts{4});
    
     img_data = fread(fid, [3, width*height], 'uint8');
         
     fclose(fid);

     img = reshape(img_data, [3, width, height]);
     image = permute(img, [3, 2, 1]);
     image = image/max_val; % 记得要归一化 不然会很亮
end
