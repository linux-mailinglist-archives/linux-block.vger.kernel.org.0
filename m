Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BA87D43BE
	for <lists+linux-block@lfdr.de>; Tue, 24 Oct 2023 02:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjJXALs (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 23 Oct 2023 20:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbjJXALq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Oct 2023 20:11:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7179E10EA;
        Mon, 23 Oct 2023 17:11:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3508C433C9;
        Tue, 24 Oct 2023 00:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698106296;
        bh=zvwxOiofUnYEQUVM/sjBEz7BUQLR9RWz7keuXQ8Z69Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IXgM+my2ElaKqHt+Hshf1daUpdqxEY2l8X799/DUGER425662bLaMjuQKSpD+rAFR
         hxTDSUm6Gaucg0qPgLS6GzIaVQp6m38cQf56oXJoiF/bx6/JJycW6gjQTcYt7fYdHs
         zk4t6GsjYL2EFYcOr0KuXu4SWU6nsBqosUD+T8K3fIVyUOH7r58dsFunS+L1YykEH6
         iOPfETiWb52lpsp8P/0RdVxdsEJGgiaVQtufFPc+rep/JMkrwsgbbiKVlcSM3bPEGZ
         T7M3XJ/di7qzVBQC1mIBss57gnBwh/3DRRao/BqlncP+hMBVD1QY04DohxHfO8xJXU
         Ovr+AUxQiFABQ==
Message-ID: <a649fef4-804d-412b-9bcf-940781f9d90a@kernel.org>
Date:   Tue, 24 Oct 2023 09:11:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 08/19] scsi: sd: Sort commands by LBA before
 resubmitting
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20231023215638.3405959-1-bvanassche@acm.org>
 <20231023215638.3405959-9-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231023215638.3405959-9-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/24/23 06:53, Bart Van Assche wrote:
> Sort SCSI commands by LBA before the SCSI error handler resubmits
> these commands. This is necessary when resubmitting zoned writes
> (REQ_OP_WRITE) if multiple writes have been queued for a single zone.
> 
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

