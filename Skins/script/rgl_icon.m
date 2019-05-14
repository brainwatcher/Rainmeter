function status=rgl_icon(prefix,varargin)
if nargin>2
    error('Too many inputs');
else
    switch nargin
        case 1
            mode=1;
        case 2
            mode=varargin{1};
    end
end
d=dir([prefix '*']);
if isempty(d)
    error 'No match files';
elseif length(d)>1
    error 'Too much matched files'
end
filename=fullfile(pwd,d.name);
[X,map,t] = imread(filename);
if ~isempty(map)
    X=ind2rgb(X,map);
end
outfilename=[prefix '2.png'];
switch mode
    case 1
        if ~isempty(t)&&length(unique(t))>1
            status=1;
            return
        else
            t0=sum(X,3)>720;
            t=ones(size(t0))*255;
            [L,n] = bwlabel(t0);
            mid_index=num2cell(round(size(L)/2));
            mid_l_index= sub2ind(size(L),mid_index{:});
            L_mid=L(mid_l_index);
            seed_density=5;
            seed=[ones(seed_density,1),round(linspace(1,size(t,2),seed_density))';
                round(linspace(1,size(t,1),seed_density))',ones(seed_density,1);
                repmat(size(t,1),seed_density,1),round(linspace(1,size(t,2),seed_density))';
                round(linspace(1,size(t,1),seed_density))',repmat(size(t,2),seed_density,1)];
            seed=unique(seed,'rows');
            for i=1:size(seed,1)
                index=num2cell(seed(i,:));
                linearIndexMatrix = sub2ind(size(L), index{:});
                if L(linearIndexMatrix)~=L_mid
                    t(L==L(linearIndexMatrix))=0;
                end
            end  
        end
    case 2
        t0=sum(X,3)<720;
        t=255*uint8(t0);
end
imwrite(X, outfilename, 'png', 'Alpha', t )
status=0;
end





