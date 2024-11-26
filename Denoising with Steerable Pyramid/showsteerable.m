% function showsteerable(coeff)
% % Show the subbands of steerable pyramid
% 
% figure();
% ht=length(coeff);
% if ht>2
%     for i=2:length(coeff)-1
%         for j=1:4
%             subplot(ht-2,4,(i-2)*4+j);
%             imshow(coeff{i}{j},[]);
%         end
%     end
% end


function showsteerable(coeff)
% Show the subbands of steerable pyramid
figure();
ht=length(coeff);
if ht>2
    for i=2:length(coeff)-1
        for j=1:4
            subplot(ht-2,4,(i-2)*4+j);
            imshow(coeff{1,i}{1,j},[]);
        end
    end
    figure;
    subplot 121,imshow(coeff{1,1},[]);
    subplot 122,imshow(coeff{1,ht},[]);
else
    subplot 121,imshow(coeff{1,1},[]);
    subplot 122,imshow(coeff{1,ht},[]);
end
