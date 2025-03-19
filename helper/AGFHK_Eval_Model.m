function [ Odata ] = AGFHK_Eval_Model( data, term, labels )
%%
%Function that returns data from a GLM model binned by observations and
%their interactions.
%
%INPUT:
%'data'         table for GLM (observation is last column)
%'term'         model specification in Wilkinson notation. NOTE: Currently
%                 only supports up two 3-way interactions!
%'labels'       labels for entries (if dichotomous) in order lower to
%                 higher value as cell array of cells {{'congruent' 'incongruent'} {'short' 'long'}}
%                 Note: Labels determines if factor is assumed to be categorical or not!
%
%%%%%OUTPUT
%Returns Odata, a structure with fields for all Table rows
%   Values are in Order: Mean | Median | SD | n entries
%20/10/16 Added support for 4-way interaction, still no solution for n-way though...
%%
n_split = 3;    %default value: parametric regressors will be split into this many bins.

%data = table(        Congruence, Distance, RSI, Error, Hand, PostError, PostIncom,  PostFar, RSI_Prev, PrevRT, HandRepeat, CongRepeat, RSIRepeat, LinRT);
%term = 'LogRT ~ Congruence + Distance +RSI +Error +Hand + PostError + PostIncom + PostFar +RSI_Prev +PrevRT +HandRepeat +CongRepeat +RSIRepeat + Distance:Congruence + PostError:Congruence + PostError:HandRepeat + PostError:HandRepeat:RSI';
warning off
term        = strrep(term,' ',[]);      %remove spaces
warning on
OnlyOneFactor = 0;
if isempty(regexp(term,'+'))
    term=[term '+']; %assume at least one factor is provided
    OnlyOneFactor = 1;
end
factors     = regexp(term,'+');         %find out how many factors are present
beginning   = regexp(term,'~')+1;       %find first factor beginning
obs         = table2array(data(:,end)); %get observations values

%some checks that would cause errors
if length(labels) == length(regexp(term,'+')) %enough labels
elseif length(labels) == length(regexp(term,'+'))-length(regexp(term,':')) %labels for actual fields but not interactions provided
    for c = 1 : length(regexp(term,':'))
        labels{end+c} = {};
    end
elseif length(labels) == length(regexp(term,'+'))-length(regexp(term,':'))
    error('Not enough labels for all fields provided.'); return
end
%%
for c = 1 : length(factors)+1-OnlyOneFactor %big loop through all factors
    %get term for this factor
    if c == 1
        FacName = term(beginning:factors(1)-1);
    elseif c == length(factors)+1
        FacName = term(factors(c-1)+1:end);
    else
        FacName = term(factors(c-1)+1:factors(c)-1);
    end
    if regexp(FacName,':','ONCE') %interaction term (knifflig)
        n_interact = regexp(FacName,':'); %how many interactions?
        for fn = 1 : length(n_interact)+1
            if fn == 1 %get each factors name
                iFacName{fn} = FacName(1:n_interact(1)-1);
            elseif fn == length(n_interact)+1
                iFacName{fn} = FacName(n_interact(fn-1)+1:end);
            else
                iFacName{fn} = FacName(n_interact(fn-1)+1:n_interact(fn)-1);
            end
            iFacPos(fn) = find(strcmp(fieldnames(data),iFacName{fn})); %which number of the table is this factor?
            d = data.(iFacName{fn});
            if length(unique(d(~isnan(d)))) == 2
                number_of_values(fn) = 2;
                unique_values{fn} = unique(d(~isnan(d)));
            else
                number_of_values(fn) = n_split;
                unique_values{fn} = 1:n_split;
            end
        end
        d1 = data.(iFacName{1});
        d2 = data.(iFacName{2});
        Ftot = 0;
        for F1 = 1 : number_of_values(1) %loop through first level values
            if number_of_values(1)>2
                lab1 = ['Split' num2str(F1)];
                d1 = ceil(n_split * tiedrank(d1) / sum(~isnan(d1)));
            else
                lab1 = labels{iFacPos(1)}{F1};
            end
            
            for F2 = 1 : number_of_values(2) %loop through second level values
                if number_of_values(2)>2
                    lab2 = ['Split' num2str(F2)];
                    d2 = ceil(n_split * tiedrank(d2) / sum(~isnan(d2)));
                else
                    lab2 = labels{iFacPos(2)}{F2};
                end
                
                if length(n_interact)==1 %two factors, End
                    Ftot = Ftot +1;
                    Finald(Ftot)        = {(d1==unique_values{1}(F1) & d2==unique_values{2}(F2))};
                    TableLable(Ftot)    = {[lab1 '_' lab2]};
                    TableName           = [iFacName{1} 'x' iFacName{2}];
                    
                elseif length(n_interact)==2 %three factors in interaction
                    d3 = data.(iFacName{3});
                    for F3 = 1 : number_of_values(3)
                        Ftot = Ftot +1;
                        if number_of_values(3)>2
                            lab3 = ['Split' num2str(F3)];
                            d3   = ceil(n_split * tiedrank(d3) / sum(~isnan(d3)));
                        else
                            lab3 = labels{iFacPos(3)}{F3};
                        end
                        Finald(Ftot)        = {(d1==unique_values{1}(F1) & d2==unique_values{2}(F2) & d3==unique_values{3}(F3))};
                        TableLable(Ftot)    = {[lab1 '_' lab2 '_' lab3]};
                     end
                    TableName = [iFacName{1} 'x' iFacName{2} 'x' iFacName{3}];
                    
                elseif length(n_interact)==3 %four factors in interaction
                    d3 = data.(iFacName{3});
                    d4 = data.(iFacName{4});
                    for F3 = 1 : number_of_values(3)
                        if number_of_values(3)>2
                            lab3 = ['Split' num2str(F3)];
                            d3   = ceil(n_split * tiedrank(d3) / sum(~isnan(d3)));
                        else
                            lab3 = labels{iFacPos(3)}{F3};
                        end
                        for F4 = 1 : number_of_values(4)
                            Ftot = Ftot +1;
                            if number_of_values(4)>2
                                lab4 = ['Split' num2str(F4)];
                                d4   = ceil(n_split * tiedrank(d4) / sum(~isnan(d4)));
                            else
                                lab4 = labels{iFacPos(4)}{F4};
                            end
                            Finald(Ftot)        = {(d1==unique_values{1}(F1) & d2==unique_values{2}(F2) & d3==unique_values{3}(F3) & d4==unique_values{4}(F4))};
                            TableLable(Ftot)    = {[lab1 '_' lab2 '_' lab3 '_' lab4]};
                        end
                     end
                    TableName = [iFacName{1} 'x' iFacName{2} 'x' iFacName{3} 'x' iFacName{4}];
                end
            end 
        end
    else %simple factor (simple)
        %find out if categorial or continuous regressor and split data up
        d = data.(FacName);
        if ~isempty(labels{c}) %categorical
            u = unique(d(~isnan(d))); %uniqe entries except for NaNs
            TableLable = labels{c};
        else %parametric
            d = ceil(n_split * tiedrank(d) / sum(~isnan(d)));
            u = unique(d(~isnan(d)));
        end
        
        for F1 = 1 : length(u)
            Finald(F1)        = {(d==u(F1))};
            if length(u)>2
                TableLable{F1} = ['Split' num2str(F1)];
            else
                if isempty(labels{c})
                    TableLable = {'Split1' 'Split2' }; %generate new lables
                end
            end
        end
        
        %Special case: This should be a parametric regressor, but has less entries than desired splits
        if isempty(labels{c}) & length(u) < n_split
            disp(['Warning: factor ' TableName ' has less entries than desired split size. Returning NaN for middle split (only if 3 splits set).'])
            TableLable = {'Split1' 'Split2' 'Split3'};
            Finald(n_split) = Finald(length(u));
            Finald{length(u)} = [];
        end
        
        TableName = FacName;
    end

    %for each entry, calculate descriptive statistics
    for fn = 1 : length(TableLable)
        if fn > 1 && size(Finald,2) == 1
            disp(['Warning: factor ' TableName ' is a constant. Returning nans for Split 2.'])
            Odata.(TableName).([TableLable{fn}])    = [NaN NaN NaN NaN];
        else
            if sum(Finald{fn}) > 2
                ObsVal = obs(Finald{fn});
                Odata.(TableName).([TableLable{fn}])    = [nanmean(ObsVal) nanmedian(ObsVal) nanstd(ObsVal) length(ObsVal)];
            else
                Odata.(TableName).([TableLable{fn}])    = [NaN NaN NaN NaN];
            end
        end
    end
    clear d Finald TableLable unqiue_values number_of_values iFacPos iFacName number_of_values iFacPos
end

