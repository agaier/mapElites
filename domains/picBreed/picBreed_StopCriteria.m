%% picBreed Stopping Criteria
function [shouldYouStop] = picBreed_StopCriteria(elite,~,~)
shouldYouStop = (elite(1).fitness == 1);
