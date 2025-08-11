package org.zerock.domain;

import java.util.List;
import java.util.Map;

import lombok.Data;

@Data
public class DashboardVO {
	private int totalPostCount;
    private int pendingPostCount;
    private int completedPostCount;

    private List<Map<String, Object>> postCountByCategory;
    private List<Map<String, Object>> postCountByType;

//    private List<QnaVO> recentQnaList; //��� �߰��� ����
    private List<PostVO> recentPosts;
    private List<NoticeVO> recentNotices;
    
    // ������
    public DashboardVO(int totalPostCount, int pendingPostCount, int completedPostCount, 
    	    List<Map<String, Object>> postCountByCategory, List<Map<String, Object>> postCountByType, 
    	    List<PostVO> recentPosts, List<NoticeVO> recentNotices) {
    	    this.totalPostCount = totalPostCount;
    	    this.pendingPostCount = pendingPostCount;
    	    this.completedPostCount = completedPostCount;
    	    this.postCountByCategory = postCountByCategory;
    	    this.postCountByType = postCountByType;
    	    this.recentPosts = recentPosts;
    	    this.recentNotices = recentNotices;
    	}
}
