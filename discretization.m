function [fea_out] = discretization(fea, fold)

[m n] = size(fea);
switch fold
    case 3
        for i = 1:n
            temp = fea(:,i);
            num_max = max(temp);
            num_min = min(temp);
            width = (num_max - num_min) / 3;
            for j = 1:m
                if temp(j) >= num_min && temp(j) <= num_min +width
                    temp(j) = 0;
                else if temp(j) > num_min+width && temp(j) <= num_min +width * 2
                        temp(j) = 1;
                    else if temp(j) > num_min+width * 2 && temp(j) <= num_max
                            temp(j) = 2;
                        end
                    end
                end
            end
            fea(:,i) = temp;
        end
        
        
    case 5
        for i = 1:n
            temp = fea(:,i);
            num_max = max(temp);
            num_min = min(temp);
            width = (num_max - num_min) / 5;
            for j = 1:m
                if temp(j) >= num_min && temp(j) <= num_min +width
                    temp(j) = 0;
                else if temp(j) > num_min+width && temp(j) <= num_min +width * 2
                        temp(j) = 1;
                    else if temp(j) > num_min+width * 2 && temp(j) <= num_min +width * 3
                            temp(j) = 2;
                        else if temp(j) > num_min+width * 3 && temp(j) <= num_min +width * 4
                                temp(j) = 3;
                            else if temp(j) > num_min +width * 4 && temp(j) <= num_max
                                    temp(j) = 4;
                                end
                            end
                        end
                    end
                end
            end
            fea(:,i) = temp;
        end
        
        
    case 7
        for i = 1:n
            temp = fea(:,i);
            num_max = max(temp);
            num_min = min(temp);
            width = (num_max - num_min) / 7;
            for j = 1:m
                if temp(j) >= num_min && temp(j) <= num_min +width
                    temp(j) = 0;
                else if temp(j) > num_min+width && temp(j) <= num_min +width * 2
                        temp(j) = 1;
                    else if temp(j) > num_min+width * 2 && temp(j) <= num_min +width * 3
                            temp(j) = 2;
                        else if temp(j) > num_min+width * 3 && temp(j) <= num_min +width * 4
                                temp(j) = 3;
                            else if temp(j) > num_min +width * 4 && temp(j) <= num_min +width * 5
                                    temp(j) = 4;
                                else if temp(j) > num_min +width * 5 && temp(j) <= num_min +width * 6
                                        temp(j) = 5;
                                    else if temp(j) > num_min +width * 6 && temp(j) <= num_max
                                            temp(j) = 6; 
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            fea(:,i) = temp;
        end
end

% for i = 1:n
%     temp = fea(:,i);
%     num_max = max(temp);
%     num_min = min(temp);
%     width = (num_max - num_min) / 4;
%     for j = 1:m
%         if temp(j) >= num_min && temp(j) <= num_min +width
%             temp(j) = 0;
%         else if temp(j) > num_min+width && temp(j) <= num_min +width * 2
%                 temp(j) = 1;
%             else if temp(j) > num_min+width * 2 && temp(j) <= num_min +width * 3
%                     temp(j) = 2;
%                 else if temp(j) > num_min+width * 3 && temp(j) <= num_max
%                         temp(j) = 3;
%                     end
%                 end
%             end
%         end
%     end
%     fea(:,i) = temp;
% end
fea_out = fea;
end

