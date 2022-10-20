Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A5F605E4B
	for <lists+linux-block@lfdr.de>; Thu, 20 Oct 2022 12:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiJTK4t (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 20 Oct 2022 06:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiJTK4s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 06:56:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532421E044A
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 03:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=WjC2ATU3FdKAY1CREXePv2H6AA+eybPyqgvUSFT4kMo=; b=EKS9/UJD3BtEzrzPZnZAyPlCZv
        HIMuF7o4THrfTqoHFz+CXXYobRG7inxmPuS8IuMQzCnOlaU7KlvyeHdtw/iVaIuxQiyI7iM4Kyqeb
        G/BANFdVS0ZD9tpXowUusHOLZwybERXsjZl5WVFETMrwThhS5D09IaNf5aEy04RfofITNxztB9t7h
        c2y5qSMhSzZJN4bc+GVroAF+AisLZv40YBPJ8Sab4l94qLBaWerZzO1Uh7eCX9TjaxIcj3HrZ2w0d
        OAYQpp0wgt6JNiaX1ikj6T80M4svmuUwYU4Wa3QA84OWBy8gSG7+ksypNxTGx8zID4XUIyyOAzmDj
        Ci5ti9bw==;
Received: from [88.128.92.117] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olTDq-00DqcY-M6; Thu, 20 Oct 2022 10:56:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: per-tagset SRCU struct and quiesce
Date:   Thu, 20 Oct 2022 12:56:00 +0200
Message-Id: <20221020105608.1581940-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

this series moves the SRCU struct used for quiescing to the tag_set
as the SRCU critical sections for dispatch take about the same time
on all queues anyway, and then adopts the series from Chao that provides
tagset-wide quiesce to use that infrastructure.
