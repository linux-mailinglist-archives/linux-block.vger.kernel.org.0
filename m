Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B0360575D
	for <lists+linux-block@lfdr.de>; Thu, 20 Oct 2022 08:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiJTGe4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 20 Oct 2022 02:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJTGez (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 02:34:55 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A3E8981D
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 23:34:52 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CF9FF68B05; Thu, 20 Oct 2022 08:34:48 +0200 (CEST)
Date:   Thu, 20 Oct 2022 08:34:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chao Leng <lengchao@huawei.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@kernel.dk,
        ming.lei@redhat.com, paulmck@kernel.org
Subject: Re: [PATCH v2 0/2] improve nvme quiesce time for large amount of
 namespaces
Message-ID: <20221020063448.GA6246@lst.de>
References: <20221020035348.10163-1-lengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020035348.10163-1-lengchao@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I though the conclusion from last round was to move the srcu_struct to
the tagset?
