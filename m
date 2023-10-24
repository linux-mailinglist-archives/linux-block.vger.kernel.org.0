Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2728C7D43B0
	for <lists+linux-block@lfdr.de>; Tue, 24 Oct 2023 02:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjJXAJr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 23 Oct 2023 20:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJXAJq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Oct 2023 20:09:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BC4D6E;
        Mon, 23 Oct 2023 17:09:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF7AC433C8;
        Tue, 24 Oct 2023 00:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698106185;
        bh=XoBcu2S1QUn1dsbbkNcfAW0O/CD8hsF+ZK3HjhYrmSU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qcbEkmHcGHLBINZhMUhmnedgbEltD0RMagYVLNrmE0syu7eSMWBAVI8XhnDPrAJ64
         HNwhyQqNaxMF7vrk8tCzlcyS3brYyHPijkTh0163soK9TzmMvDobnPUJXLdvBL0VZQ
         g0tiGSE6o70Oka4HA1EZFuxZoUgB9oyThA25BzH+DbaxQG2jvboMFfmNolwn0YQ3IO
         dAMIV/9UYSGX5BXaGxVkKQidKBF7f3vapgaNSUyY7SSu44hz12mPT5RQEPx3THWEXN
         vvjC01pVvG/soDRlgfJpt2AnQKrXwN1I+bK6doCqciTCW60hJn06vRi1rNypP7HekV
         XFL+CP+EkuXjQ==
Message-ID: <3ed4d82b-1d3d-4b41-8266-ca43f79ee7de@kernel.org>
Date:   Tue, 24 Oct 2023 09:09:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 06/19] scsi: core: Introduce a mechanism for
 reordering requests in the error handler
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20231023215638.3405959-1-bvanassche@acm.org>
 <20231023215638.3405959-7-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231023215638.3405959-7-bvanassche@acm.org>
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
> Introduce the .eh_needs_prepare_resubmit and the .eh_prepare_resubmit
> function pointers in struct scsi_driver. Make the error handler call
> .eh_prepare_resubmit() before resubmitting commands if any of the
> .eh_needs_prepare_resubmit() invocations return true. A later patch
> will use this functionality to sort SCSI commands by LBA from inside
> the SCSI disk driver before these are resubmitted by the error handler.
> 
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

