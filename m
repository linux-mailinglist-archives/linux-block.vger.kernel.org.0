Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F2B78ED7A
	for <lists+linux-block@lfdr.de>; Thu, 31 Aug 2023 14:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243484AbjHaMnD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 31 Aug 2023 08:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239553AbjHaMnB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Aug 2023 08:43:01 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FE9E49
        for <linux-block@vger.kernel.org>; Thu, 31 Aug 2023 05:42:53 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 39B6E68D0A; Thu, 31 Aug 2023 14:42:49 +0200 (CEST)
Date:   Thu, 31 Aug 2023 14:42:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Li Lingfeng <lilingfeng@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
        tj@kernel.org, yukuai1@huaweicloud.com, houtao1@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] block: don't add or resize partition on the disk with
 GENHD_FL_NO_PART
Message-ID: <20230831124248.GA11508@lst.de>
References: <20230831075900.1725842-1-lilingfeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831075900.1725842-1-lilingfeng@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
