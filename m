Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690C45F9A2F
	for <lists+linux-block@lfdr.de>; Mon, 10 Oct 2022 09:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiJJHly (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 10 Oct 2022 03:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiJJHko (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2022 03:40:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A510A1A809
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2022 00:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=n47IwfmdswHhdP6AYi3QGZhChq
        ltjIQo74kBEZ8fXVM6GS7TJScaYdPgSbYo9SxoRf0d2/DBT05DD6DYtOIiweTOVM23abdQYcwZbXg
        vj2JyKHn+6GvjQWU8tTIK0V5zIewxWutlT5thFy/TkhAJh+OBlY10OKYUBDxWiZMfkTqq0a8nSvhf
        axke3Pg3eY5pLK8CXhdPmZSSZvX0noKZc7/YtdulhURlMF1f/VRP2uMFeNxb4X6jFdF1mL/9Amor0
        P2AiR87O4AkgJSiAWHaT/wFw8Do0JQHp7U9+xs1rlX+xE0z1RXWshxbbBhI/n6dsnLRxaS3rj9zQ9
        emtwiRzg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ohn3p-00HN5B-Hm; Mon, 10 Oct 2022 07:18:49 +0000
Date:   Mon, 10 Oct 2022 00:18:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-block@vger.kernel.org, Nico Pache <npache@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Subject: Re: [PATCH v2] block: avoid sign extend problem with default queue
 flags mask
Message-ID: <Y0PHWeOSFkvAgSV6@infradead.org>
References: <20221003133534.1075582-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003133534.1075582-1-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
