Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B800F6128EF
	for <lists+linux-block@lfdr.de>; Sun, 30 Oct 2022 09:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiJ3IGi (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 30 Oct 2022 04:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiJ3IGh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 04:06:37 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFD06413;
        Sun, 30 Oct 2022 01:06:36 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F009F68AFE; Sun, 30 Oct 2022 09:06:32 +0100 (CET)
Date:   Sun, 30 Oct 2022 09:06:32 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Mike Christie <michael.christie@oracle.com>, bvanassche@acm.org,
        hch@lst.de, martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        james.bottomley@hansenpartnership.com, linux-block@vger.kernel.org,
        dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
        linux-nvme@lists.infradead.org, chaitanyak@nvidia.com,
        target-devel@vger.kernel.org
Subject: Re: [PATCH v3 08/19] nvme: Move pr code to it's own file
Message-ID: <20221030080632.GI4214@lst.de>
References: <20221026231945.6609-1-michael.christie@oracle.com> <20221026231945.6609-9-michael.christie@oracle.com> <Y1q6so/3Hx9GZmTz@kbusch-mbp.dhcp.thefacebook.com> <370e66bd-81d0-5451-850e-50a4172ed64f@oracle.com> <Y1wFjHzza1QYTzdG@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1wFjHzza1QYTzdG@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 28, 2022 at 10:38:36AM -0600, Keith Busch wrote:
> I think I was just the last person to touch the code, but it was mostly
> developed elsewhere. So "no", don't bother propagating the (c).

You actually did write the PR ops code.  I wrote the core and SCSI
side, and you added NVMe.
