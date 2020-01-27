Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A27814A889
	for <lists+linux-block@lfdr.de>; Mon, 27 Jan 2020 18:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgA0REA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 27 Jan 2020 12:04:00 -0500
Received: from ale.deltatee.com ([207.54.116.67]:42184 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgA0RD7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jan 2020 12:03:59 -0500
Received: from [172.16.1.162]
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1iw7nn-0003MP-NE; Mon, 27 Jan 2020 10:03:56 -0700
To:     Daniel Wagner <dwagner@suse.de>, linux-block@vger.kernel.org
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Omar Sandoval <osandov@fb.com>
References: <20200127145353.52129-1-dwagner@suse.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a84f53ab-3f76-df73-e9f7-fb57c03eeb2d@deltatee.com>
Date:   Mon, 27 Jan 2020 10:03:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200127145353.52129-1-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: osandov@fb.com, Johannes.Thumshirn@wdc.com, linux-block@vger.kernel.org, dwagner@suse.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH blktests] nvme/018: Ignore message generated by nvme read
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020-01-27 7:53 a.m., Daniel Wagner wrote:
> nvme-cli writes 'CAP_EXCEEDED' message also on stdout not just
> stderr. This lets the test fail as well.
> 
> Fixes: 1aee5f430b30 ("nvme/018: Ignore error message generated by nvme read")
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  tests/nvme/018 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/nvme/018 b/tests/nvme/018
> index 0a5b4c2ab019..d0f15db23538 100755
> --- a/tests/nvme/018
> +++ b/tests/nvme/018
> @@ -43,7 +43,7 @@ test() {
>  	sectors="$(blockdev --getsz "/dev/${nvmedev}n1")"
>  	bs="$(blockdev --getbsz "/dev/${nvmedev}n1")"
>  
> -	nvme read "/dev/${nvmedev}n1" -s "$sectors" -c 0 -z "$bs" 2>"$FULL" \
> +	nvme read "/dev/${nvmedev}n1" -s "$sectors" -c 0 -z "$bs" &>"$FULL" \
>  		&& echo "ERROR: Successfully read out of device lba range"

That's an odd message for an error... Error! I succeeded!

>  	nvme disconnect -n "${subsys_name}"
> 
