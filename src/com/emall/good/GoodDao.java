package com.emall.good;

import java.util.List;

public interface GoodDao {
	List<Good> getPage(int page, String like_string);
	Good getGoodById(String goodId);
}
