Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C82615C99
	for <lists+linux-block@lfdr.de>; Wed,  2 Nov 2022 08:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiKBG76 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 2 Nov 2022 02:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiKBG74 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 02:59:56 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18CB637D;
        Tue,  1 Nov 2022 23:59:48 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2EC016732D; Wed,  2 Nov 2022 07:59:46 +0100 (CET)
Date:   Wed, 2 Nov 2022 07:59:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     axboe@kernel.dk, hch@lst.de, chaitanyak@nvidia.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] blk-mq: use if-else instead of goto in
 blk_mq_alloc_cached_request()
Message-ID: <20221102065945.GB9096@lst.de>
References: <cover.1667358114.git.nickyc975@zju.edu.cn> <d3306fa4e92dc9cc614edc8f1802686096bafef2.1667358114.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3306fa4e92dc9cc614edc8f1802686096bafef2.1667358114.git.nickyc975@zju.edu.cn>
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
