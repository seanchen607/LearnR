# http://kzing.net/blog/%E7%AE%97%E6%B3%95:-%E5%90%88%E5%B9%B6%E6%9C%89%E4%BA%A4%E9%9B%86%E7%9A%84%E9%9B%86%E5%90%88
# 用R实现

a = c('a', 'b')
b = c('b', 'c')
c = c('d', 'e', 'f')
d = c('b', 'qq', 'dada')
e = c('g', 'c')
f = c('eee')
some_sets <- list(a , b, c, d, e, f)

union_intersect_sets <- function(some_sets){
    # 给定一些集合, 合并这些集合中所有有交集的集合
    # 步骤:
    #     1. 为每个集合编号
    #     2. 取出所有集合中的元素, 创建一个字典, 保存元素所在的集合的编号.
    #     3. 创建关系数组relations, 其大小为输入集合的数量, 表示集合的合并关系.
    #         如: relations[5] == 3, 则表示集合5要合并到集合3
    #     4. 遍历步骤二创建的字典, 将value中的所有集合都合并到编号最小的集合中
    #         如: 存在item_set_dict['a'] = 1,3,5, 表示元素a存在于编号为1,3,5的集合中. 故合并3和5到1中,
    #             合并操作通过修改relations实现, 此时有relations[3] == 1, relations[5] == 1

    item_set_dict <- list()
    for (i in 1:length(some_sets)){
        for (s in some_sets[[i]]){
            if (is.null(item_set_dict[[s]])) item_set_dict[[s]] <- i else item_set_dict[[s]] <- c(item_set_dict[[s]], i)
        }
    }
    relations = 1:length(some_sets)
    for (set_ids in item_set_dict){
        union_to_ids = c()
        for (id in set_ids){
            while (id != relations[id]){
                id = relations[id]
            }
            union_to_ids <- c(union_to_ids, id)
        }
        union_to = min(union_to_ids)

        for (id in set_ids){
            relations[id] = union_to
        }
        for (id in union_to_ids){
            relations[id] = union_to
        }
    }
    result <- list()
    for (i in 1:length(relations)){
        id <- relations[i]
        while (id != relations[id]){
            id = relations[id]
        }
        if (is.null(result[[as.character(id)]])) result[[as.character(id)]] <- some_sets[[i]] else result[[as.character(id)]] <- c(result[[as.character(id)]], some_sets[[i]])
    }
    result
}

union_intersect_sets_faster <- function(some_sets){
    # 给定一些集合, 合并这些集合中所有有交集的集合

    # 基本思路同上一个算法, 创建两个特殊的字典保存集合和元素的关系.
    # 主循环为对所有集合的遍历, 每一个循环, 贪婪的动态的寻找元素所在的集合, 又通过找到的新的集合中的
    # 元素去寻找新的集合, 一直到找不到新的集合为止.
    names(some_sets) <- as.character(1:length(some_sets))
    item_set_dict <- list()
    for (i in 1:length(some_sets)){
        for (s in some_sets[[i]]){
            if (is.null(item_set_dict[[s]])) item_set_dict[[s]] <- i else item_set_dict[[s]] <- c(item_set_dict[[s]], i)
        }
    }

    set_idss = names(some_sets)  # 拷贝所有的集合编号
    for (set_ in set_idss){
        items <- some_sets[[set_]]
        some_sets[[set_]] <- NULL
        if (is.null(items))
            next

        new_items <- items
        while (length(new_items)){
            from_sets <- c()
            for (item in new_items){
                from_sets <- unique(as.character(c(from_sets, item_set_dict[[item]])))
            }

            new_items <- c() # 新结合的item
            for (from_set in from_sets){
                item_ <- some_sets[[from_set]]
                if (is.null(item_))
                    next
                new_items <- c(new_items, item_)
                items <- c(items, item_)
                some_sets[[from_set]] <- NULL # 置为空
            }
        }
        some_sets[[set_]] <- items
    }
    some_sets
}


