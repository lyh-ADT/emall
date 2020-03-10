package com.emall.good;

import java.util.List;

public interface GoodService {
	List<GoodController.Good> getPage(int page, String search);
}
