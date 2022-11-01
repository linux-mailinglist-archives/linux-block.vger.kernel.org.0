Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCFC614E43
	for <lists+linux-block@lfdr.de>; Tue,  1 Nov 2022 16:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiKAPZS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 1 Nov 2022 11:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKAPZR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 11:25:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEE46419
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 08:25:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8DE1CB81BED
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 15:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D49C433C1;
        Tue,  1 Nov 2022 15:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667316314;
        bh=4/shBww2/TLXQAtcIfgbWMWwCcBjdhWufZJartaxi+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=saQ5QPxZTcK5CfjYcwKSkWjx+jQDsSb7+3HSwD8V6EDh1gQrkl6iW0r3WD062q8hK
         UUfMPVaDYBZnQwX7jacAMN1K0jpCSTNZ+7pt8YdRd8nkMBoNfxUi2iS/ckvMM966s3
         pTV0uoQiKqBI4z56bJeMwvNCCvJKFuF9Lrw68uin5FBZX4zrgerfXJ5eS9WtJu9Rmt
         fEuCihjkGz4IU6fmdBCVqu5BLUsMIrdoZ6xrIeSs1MBqkSYsGCSMZsyW5rOyXwiz8r
         YPMsDBM22BLZ842VVRUHWi/QnbJyQNTtKDvGgI8O8fnlYH7erp4/qWUVMHIG+cs5wZ
         k1CVx+6XQ231Q==
Date:   Tue, 1 Nov 2022 09:25:10 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: per-tagset SRCU struct and quiesce v3
Message-ID: <Y2E6VsyMRfjrOvEh@kbusch-mbp>
References: <20221101150050.3510-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101150050.3510-1-hch@lst.de>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The series looks good!

Reviewed-by: Keith Busch <kbusch@kernel.org>
