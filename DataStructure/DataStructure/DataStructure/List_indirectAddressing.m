//
//  List_indirect addressing.m
//  DataStructure
//
//  Created by 夯大力 on 17/1/6.
//  Copyright © 2017年 Handyzzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <stdio.h>
#include <stdlib.h>


typedef int  ListItem;
typedef ListItem *addr;
typedef struct indlist *List;
typedef struct indlist{
    int n;
    int maxsize;
    addr *table;
}Indlist;
//slove error
void Error(char*a){
    printf("%s\n",a);
    exit(1);
}
//print
void ItemShow(int x){
    printf("此时表中全部元素是：%d\n",x);
}

//add new node
addr NewNode(){
    addr add;
    if((add=(addr)malloc(sizeof(int)))==0)  //为某节点分配内存，返回类型是 int *
    {
        Error("Exhausted memory");
        exit(0);
    }

    return add;
}


//init the list
List ListInit(int size){
    List L = malloc(sizeof(*L));
    L->n = 0;
    L->maxsize = size;
    L->table = malloc(size*sizeof(addr));
    return L;
}

//Whether the table is empty？
int ListEmpty(List L){
    return L->n == 0;
}
//get the list length
int ListLength(List L){
    return L->n;
}
//表中k位置处的元素
ListItem ListRetrieve(int k,List L){
    if(k<1 || k >L->n){
        Error("outofbounds");
    }
    return *L->table[k-1];
}
//表中x在表中的位置
int ListLocate(ListItem x, List L){
    int i;
    for (i = 0; i < L->n; i++) {
        if (*L->table[i] == x) {
            return ++i;
        }
    }
    return 0;
}
//表元素插入运算
void ListInsert(int k,ListItem x,List L){
    int i;
    if (k < 0 || k>L->n) {
        Error("outofbounds");
    }
    if (L->n == L->maxsize) {
        Error("outofbounds");
    }
    for (i = L->n-1; i >= k; i--) {
        L->table[i+1] = L->table[i];
    }
    L->table[k] = NewNode();
    *L->table[k] = x;//对比数组实现表的时候这里是个二级指针 这里table是int**类型 数组实现表的时候是int*类型
    L->n++;
}

//表元素删除运算
ListItem ListDeleta(int k,List L){
    int i;
    ListItem x;
    addr p;
    if (k < 1 || k > L->n) {
        Error("out of bounds");
    }
    p = L->table[k-1];
    x = *p;
    for (i = k; i < L->n; i++) {
        L->table[i-1] = L->table[i];
    }
    L->n--;
    free(p);
    return x;
}
//输出表
void PrintList(List L){
    int i;
    if (ListLength(L)==0) {
        printf("表是空的\n");
    }
    for (i = 0; i < L->n; i++) {
        ItemShow(*L->table[i]);
    }
}

int main(void){
    
    List L = ListInit(100);
    PrintList(L);
    
    ListEmpty(L);
    PrintList(L);
    
    ListLength(L);
    PrintList(L);
    
    ListInsert(0, 1, L);
    PrintList(L);
    
    ListDeleta(1, L);
    PrintList(L);

    
    
}



