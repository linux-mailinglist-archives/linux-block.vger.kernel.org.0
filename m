Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 484FB34B52
	for <lists+linux-block@lfdr.de>; Tue,  4 Jun 2019 17:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfFDPAR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 4 Jun 2019 11:00:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32906 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbfFDPAR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jun 2019 11:00:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id h17so10537998pgv.0
        for <linux-block@vger.kernel.org>; Tue, 04 Jun 2019 08:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5JYvPTjCSiWGm9IxtKLxvJcV9+FuTvo2S+LOE+g4DvA=;
        b=Fn5Kww4e9pxvxFXt26wbCK4gcPx2GnSgPGKl2JYw1P9BZXkTh6/XB/dpV0GWxxRxln
         j9y3hj+gd5m98s8AagwThtiyDKTgbtyYBGrpM4LyZv8XDpZFoTd2jTe69TdAaS62BdPk
         QC+RT3VZX0R2PZjcS9v+yOwWI9pm3uuw3QMO08tUgYON+NHhELWj41VpHHvV+rhSCW7M
         JuxpXxblhvjowEPGOQ37lddXWVRrwABjmozxA2yxAKmYd/6eGjgwlCYGU20DHB6qsuGK
         a27C1eHI4NEYJgC20CuNnQ+TENaaPAqvW7WDinMmTzzHP7CWkz8Quq2l9haJuN6NFpzN
         r51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5JYvPTjCSiWGm9IxtKLxvJcV9+FuTvo2S+LOE+g4DvA=;
        b=kISLpT3uy//rCQndQlssTHJJnRLqoM8kVohxlE4DgDoCUwkPAalEJpTHEj2zKOIXwp
         aGB/GC4Ol5+0+yO+1MBfhMBdnA54w0U+x4958kVPI7HqvOU8BSd/l8aPeg1QtjeuuelH
         COcLF4pAGAgXhh7fDgHDEdZXhtVi54PJZqmfKuuBrLt1wtGGovqAleH8gecfGq4YbHGZ
         FBSAQK1/CVUOkqlEiw3SZuzy9zWlBYH3biSMYjtO+FXkDJ2kzMStXjNbfYaUXqPg0AXR
         fcKGWmwK6edjc246/sZYm30S6nSHW0wzBj+lt4rn1yRQGm0WDmjNgYJEeJM/zWkw3SfA
         CDuQ==
X-Gm-Message-State: APjAAAXm0uA0ogFE2jGTjYjpMTvYWV2+ZJkL14m2nBC/63rA5LgNDtDp
        iJxsdUAltFPksc2ZpMtaJJ4eNg==
X-Google-Smtp-Source: APXvYqx4GD9OinZImahExDMY6Lx/BeaFTQ9lTBMsXg8Wfc37YyoNQ9P5g6bYn6nWPwTsgU/F+CRt3Q==
X-Received: by 2002:a62:1a8e:: with SMTP id a136mr1736163pfa.22.1559660416652;
        Tue, 04 Jun 2019 08:00:16 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s9sm6275668pjp.7.2019.06.04.08.00.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 08:00:15 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Hand over skd maintainership
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>
References: <20190603234019.107514-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b7026286-007c-7fec-0a22-3c8dc75fa020@kernel.dk>
Date:   Tue, 4 Jun 2019 09:00:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603234019.107514-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/3/19 5:40 PM, Bart Van Assche wrote:
> Since I do no longer have access to any STEC SSDs, hand over
> maintainership of the skd driver to Damien who still has access to
> STEC SSDs.

Applied, thanks.

-- 
Jens Axboe

