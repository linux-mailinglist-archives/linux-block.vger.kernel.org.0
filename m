Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDFE60D047
	for <lists+linux-block@lfdr.de>; Tue, 25 Oct 2022 17:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbiJYPUd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 25 Oct 2022 11:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbiJYPTS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 11:19:18 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D5C194FA0
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 08:19:17 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 64F1F68B05; Tue, 25 Oct 2022 17:19:14 +0200 (CEST)
Date:   Tue, 25 Oct 2022 17:19:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        hch@lst.de, kbusch@kernel.org, oren@nvidia.com,
        chaitanyak@nvidia.com, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 1/1] nvme: use macro definitions for setting
 reservation values
Message-ID: <20221025151914.GA23422@lst.de>
References: <20221002082851.13222-1-mgurtovoy@nvidia.com> <cfd01d2e-1f87-2295-13bb-c8705b3335f9@grimberg.me> <3354c32d-34b3-0997-3a59-8fc199e6640a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3354c32d-34b3-0997-3a59-8fc199e6640a@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 03, 2022 at 01:16:36PM +0300, Max Gurtovoy wrote:
>> I'd make this named nvme_pr_type
>
> Most of the enums of this header are not named.
>
> I don't understand what is the convention here.
>
> Usually, if it's not a new header file I'm trying to keep the file 
> convention and this is what I did.
>
> If all agree on named, I'll send another version.

I think named is better, nvme has some weird unnamed enums that
even combine totally unrelated fields which I always found confusing.
