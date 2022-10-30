Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7764612B2C
	for <lists+linux-block@lfdr.de>; Sun, 30 Oct 2022 16:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiJ3PYO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 30 Oct 2022 11:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ3PYN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 11:24:13 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D11BE4
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 08:24:10 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4812468AA6; Sun, 30 Oct 2022 16:24:06 +0100 (CET)
Date:   Sun, 30 Oct 2022 16:24:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 1/6] block: clear the holder releated fields when
 deleting the kobjects
Message-ID: <20221030152405.GA9676@lst.de>
References: <20221020164605.1764830-1-hch@lst.de> <20221020164605.1764830-2-hch@lst.de> <cc7d4e79-a14d-1183-09a2-337052321e3e@huaweicloud.com> <868b6d4f-9306-0469-149a-47e5d282d141@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <868b6d4f-9306-0469-149a-47e5d282d141@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 21, 2022 at 11:22:05AM +0800, Yu Kuai wrote:
> I just verify that with this patchset applied, and together with the
> following patch to add some delay:

Yes, that's because we should only blow away the slave_dir and not
bd_holder_dir.
